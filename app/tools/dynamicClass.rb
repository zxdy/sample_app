require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'
require 'pp'
require 'show_data'

#database.yml
# PROD:
#   adapter:  oracle_enhanced
#   database: 192.168.231.128/orcl
#   username: tantan
#   password: oracle
# BTS:
# adapter:  oracle_enhanced
# database: 192.168.231.128/orcl
# username: tantan
# password: oracle


$db_config = YAML::load(File.open('database.yml'))
$tables_config=YAML::load(File.open('tables.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))

class Prod_database < ActiveRecord::Base
  self.abstract_class = true
  establish_connection $db_config['PROD']
end

class Bts_database < ActiveRecord::Base
  self.abstract_class = true
  establish_connection $db_config['BTS']
end


class MetaProgrammingTest
  def self.create_class(table_name,env)
    if env=='P'
      db_conn=Prod_database
    elsif
      db_conn=Bts_database
    end
    class_name = (env+table_name).capitalize
    dy_class = Object.const_set(class_name, Class.new(db_conn))
    dy_class.class_eval do
      self.table_name = table_name
    end
    dy_class
  end

end


module Prod

  class User < Prod_database
    self.table_name = "users"
  end
end

module Bts
  # class User < Bts_database
  #   self.table_name = "users"
  # end
end

# puts Prod::Test_raw.all.count
# params={
#     :pool => 'aaaa',
#     :start_date => '20141108',
#     :end_date => '20141109'
# }
# puts "****"
# puts Prod::Test_raw.where("timestamp>= to_date(:start_date,'yyyymmdd') AND\
#  timestamp <= to_date(:end_date,'yyyymmdd')+1",{start_date:\
#   params[:start_date], end_date: params[:end_date]}).count
#
# puts "****"
# puts Prod::Test_raw.where("pool=:pool and timestamp>= to_date(:start_date,'yyyymmdd') AND\
#  timestamp <= to_date(:end_date,'yyyymmdd')+1",{pool:params[:pool],start_date:\
#   params[:start_date], end_date: params[:end_date]}).count

# puts "prod: "+Prod::User.all.count.to_s

params={
    :pool => 'msj2',
    :start_date => '20141101',
    :end_date => '20141101'
}

env_rpt={}

def get_data_rpt(server_type,env,params)
  table_rpt={}
  $tables_config[server_type].split(' ').each do |table_name|
    # puts "bts:" +table+ ' - '+ MetaProgrammingTest.create_class(table,Bts_database).all.count.to_s
    begin
      table=MetaProgrammingTest.create_class(table_name,env)
      data_count=table.where("pool=:pool and timestamp>= to_date(:start_date,'yyyymmdd') AND\
              timestamp <= to_date(:end_date,'yyyymmdd')+1",{pool:params[:pool],start_date:\
              params[:start_date], end_date: params[:end_date]}).count
      table_rpt[table_name]=data_count
    rescue Exception =>e
      table_rpt[table_name]=e
    end
  end
  return table_rpt
end

puts Time.now
env_rpt['bts']=get_data_rpt("MMP",'B',params)
env_rpt['prod']=get_data_rpt("MMP",'P',params)
# env_rpt.push(get_data_rpt("MMP",Prod_database,params))
# puts env_rpt
# PP.pp(env_rpt, $>, 40)
puts format_data(env_rpt)
puts Time.now
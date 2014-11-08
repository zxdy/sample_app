require 'rubygems'
require 'active_record'
require 'yaml'
require 'logger'

$config = YAML::load(File.open('database.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))

class Prod_database < ActiveRecord::Base
  self.abstract_class = true
  establish_connection $config['PROD']
end

class Bts_database < ActiveRecord::Base
  self.abstract_class = true
  establish_connection $config['BTS']
end


module Prod
  class Test < Prod_database
    self.table_name =  "test_raw"
  end
end

module Bts
  class Test < Bts_database
    self.table_name =  "test"
  end
end

puts Prod::Test.all.count
params={
    :pool => 'aaaa',
    :start_date => '20141108',
    :end_date => '20141109'
}
puts "****"
puts Prod::Test.where("timestamp>= to_date(:start_date,'yyyymmdd') AND\
 timestamp <= to_date(:end_date,'yyyymmdd')+1",{start_date:\
  params[:start_date], end_date: params[:end_date]}).count

puts "****"
puts Prod::Test.where("pool=:pool and timestamp>= to_date(:start_date,'yyyymmdd') AND\
 timestamp <= to_date(:end_date,'yyyymmdd')+1",{pool:params[:pool],start_date:\
  params[:start_date], end_date: params[:end_date]}).count

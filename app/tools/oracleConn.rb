require 'oci8'

conn_bts = OCI8.new('tantan/oracle@//192.168.231.128:1521/orcl')
conn_bts.exec(" SELECT * FROM ALL_TABLES")do |r|
  puts r.join(',')
end



require 'net/http'

uri = URI('http://www.baidu.com')

proxy_addr = '218.92.227.173'
proxy_port = 13366


Net::HTTP.new(uri, nil, proxy_addr, proxy_port).start { |http|
  # always proxy via your.proxy.addr:8080
  res = Net::HTTP.get_response(uri)
  puts res.code
  puts res.message
}
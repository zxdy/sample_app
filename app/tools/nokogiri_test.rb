require 'rubygems'
require 'nokogiri'
require 'open-uri'

url="http://pachong.org/area/short/name/us.html"
page = Nokogiri::HTML(open(url))
page.css('table').css('tbody').css('tr').each do |ip|
  puts ip.css('td')[1].text
  puts ip.css('td')[2].text
end
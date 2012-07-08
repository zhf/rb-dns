#!/usr/bin/ruby
# rdig Client

require 'socket'
require 'base64'
require 'net/http'

def up?(site)
  Net::HTTP.new(site).head('/').kind_of? Net::HTTPOK
end

# if server_host == nil || hostname == nil
if ARGV.size != 2
    puts "Usage: #{File.basename($0)} <host-to-dig> <rdig-server>"
    exit 1
end

server_port = 9901
port = 9902
hostname = ARGV[0]
server_host = ARGV[1]

s = UDPSocket.new
s.bind('', port)
print ";; Querying #{hostname}\n"
request = Base64::encode64(hostname)
s.send(request, 0, server_host, server_port)
response, sender = s.recvfrom(1024)
puts ";; Got answer:"
address_list = Base64::decode64(response)

puts address_list

# address_list.each do |a| 
#   print a
#   print "\tHTTP OK" if up?(a)
#   print "\n"
# end
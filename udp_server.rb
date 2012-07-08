#!/usr/bin/ruby -w
# UDP DNS Server

require 'socket'
require 'resolv'
require 'base64'

port = 9901
client_port = 9902

def show_query_result(addr_array)
	addr_array.each { |addr| print "\t#{addr}\n" }
end

s = UDPSocket.new
s.bind('', port)
loop do
	request, sender = s.recvfrom(512)
	hostname = Base64::decode64(request)
	puts "\n;; Querying #{hostname} ..."
	addresses = Resolv::DNS.new.getaddresses(hostname)
	show_query_result(addresses)
	remote_client = sender[3]
	response = Base64::encode64(addresses.join("\n"))
	puts ";; Sending reply to #{remote_client} ..."
	s.send(response, 0, remote_client, client_port)
	puts ";; Done."
end

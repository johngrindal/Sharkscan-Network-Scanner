#encoding: utf-8

#a method to check for missing gems 
def check_gem
	begin
		gem 'em-websocket'
	rescue Gem::LoadError
		missing_gem_0 = true
		missing_gem_name0 = "socket"
	else
		#donothing
	end

	begin 
		gem 'net-ping', '>=1.7.8'
	rescue Gem::LoadError
		missing_gem_1 = true
		missing_gem_name1 = "net-ping"
	else
		#donothing
	end

	# install gems if they are missing

	if missing_gem_0 == true
		puts "it appears you are missing the #{missing_gem_name0} gem"
		puts "would you like to install it now"
		print "y/n:"
		answer1 = gets.chomp
		if answer1 == "y" || answer1 == "yes"
			system("clear")
			system("gem install #{missing_gem_name0}")
			puts "done"
		elsif answer1 == "n" || answer1 == "no"
			system("clear")
		puts "if you would like to install this gem manually type gem install #{missing_gem_name0}"
			sleep 5
			puts "\n"
			puts "exiting ..."
			sleep 3 
			abort("")
		end
	end
	if missing_gem_1 == true
		puts "it appears you are missing the #{missing_gem_name1} gem"
		puts "would you like to install it now"
		print "y/n:"
		answer1 = STDIN.gets.chomp
		if answer1 == "y" || answer1 == "yes"
			system("clear")
			system("gem install #{missing_gem_name1}")
			puts "done"
		elsif answer1 == "n" || answer1 == "no"
			system("clear")
			puts "if you would like to install this gem manually type gem install #{missing_gem_name1}"
			sleep 5
			puts "\n"
			puts "exiting ..."
			sleep 3 
			abort("")
		end
	end
end

def scan_all_ports
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

end
def scan_specific
	system("clear")
	puts "SCAN SPECIFIC PORTS"
	puts "\n"
	puts "\n"
	print 'HOST TO SCAN:'
	ip=STDIN.gets.chomp
	print "PORT TO SCAN:"
	port=STDIN.gets.chomp
	@icmp = Net::Ping::ICMP.new(ip)


	if @icmp.ping
		valid = true
	else
		valid = false
	end

	if valid == true
		begin
			TCPSocket.new(ip, port)
		rescue
			system("clear")
			puts "::PORT #{port} APPEARS TO BE CLOSED::"
			puts "::BUT #{ip} IS A STILL A VALID HOST::"
			print "would you like to scan all the rest of the ports on #{ip} y/n:"
			question=STDIN.gets.chomp
			if question == "y" || question == "yes"
				scan_all_ports
			else
				puts "okay."
			end
		else
			system("clear")
			puts "::PORT #{port} APPEARS TO BE OPEN::"
			puts "::HOST #{ip} IS RUNNING::"
			puts "::#{ip} REPLIED TO IMCP PING::"
			puts "\n"
			puts "\n"
			puts "::::THANK YOU FOR USING SHARKSCAN::::"
		end
	else
		system("clear")
		puts "ERROR:::: #{ip} IS NOT A VALID HOST ON THE NETWORK"
	end 

end

def require_all
	#a method to require all of the gems
	require 'net/ping'
	require 'timeout'
	require 'socket'
end
def ping_of_death 	
	puts "PING OF DEATH"
	puts "\n"
	puts "\n"
	puts "WARNING THIS MAY HARM THE TARGET"
	print "TARGET IP"
	ip = STDIN.gets.chomp

	#send ping
	os.system("ping -l 65510 #{ip}" )
	puts "SENDING MORE PACKETS..."
	os.system("ping -l 100000 #{ip}")
	puts "DONE."
end


def ip_scan
	require_root
	def local_ip
		orig = Socket.do_not_reverse_lookup  
	Socket.do_not_reverse_lookup =true 
	UDPSocket.open do |s|
			s.connect '64.233.187.99', 1 
			s.addr.last
	end
	ensure
		Socket.do_not_reverse_lookup = orig
	end
	startnum = 1
	ip_limit = 225

	until startnum == ip_limit do
		ip_est1 = "192.168.0.#{startnum}"
		ip_est2 = "192.168.1.#{startnum}"
		ip_est3 = "172.16.0.1.#{startnum}"
		if ip_est1 == local_ip 
			ipaddress = '1'
		end 
		if ip_est2 == local_ip
			ipaddress = '2'
		end 
		if ip_est2 == local_ip
			ipaddress = '3'
		end
		startnum += 1 
	end 

	
	if ipaddress == '1'
		system('clear')
		puts "SCANNING..."
		puts "THIS MAY TAKE A WHILE..."
		puts "\n"
		range = 225
		start_num = 0
		(1..range).each do
  		start_num += 1
  		ip = "192.168.0.#{start_num}"
  		@icmp = Net::Ping::ICMP.new(ip)
  		if @icmp.ping
  		puts "#{ip}"
        	else
        	end
		end
	elsif ipaddress == '2'
		system('clear')
		puts "SCANNING..."
		puts "\n"
		range = 225
		start_num = 0
		(1..range).each do
  		start_num += 1
  		ip = "192.168.0.#{start_num}"
  		@icmp = Net::Ping::ICMP.new(ip)
  		if @icmp.ping
  		puts "reply from #{ip}"
        	else
        	end
		end
	elsif ipaddress == '3'
		system('clear')
		puts "SCANNING..."
		puts "\n"
		range = 225
		start_num = 0
		(1..range).each do
  		start_num += 1
  		ip = "172.16.0.#{start_num}"
  		@icmp = Net::Ping::ICMP.new(ip)
  		if @icmp.ping
  		puts "reply from #{ip}"
        	else
        	end
		end
		
	else
		system("clear")
		puts "COULD NOT DETECT PREFIX"
		puts "\n"
		puts "\n"
		puts "ENTER THE FIRST PREFIX ON YOUR NETWORK"
		puts "FOR EXAMPLE -- 192.168.0.1 -- or -- 172.16.0.1"
		print "PREFIX:"
		prefix = STDIN.gets.chomp
 		
		puts prefix "[-1, 1]"
	end
end 

def scan_services
	system('clear')
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
	puts "scanning machine....."
	until counter == service_num do
		begin
			Timeout::timeout(2){TCPSocket.new(ip, ports[counter])}
		rescue

		else
			ports[counter] = "true"
		end
		counter += 1
	end
	puts "determining services....."
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
	puts "services::"
	puts "\n"
	until counter_3 == service_num2 do
		if res_values[counter_3] == true
			puts res_names[counter_3]	
		end 
		counter_3 += 1
	end

end




def require_root
	if ENV["USER"] != "root"
		exec("sudo #{ENV['_']} #{ARGV.join(' ')}")
	end
end
#startprocess
check_gem 

argv1 = ARGV.first

#test for arguments
if argv1 == "scan_specific_port" || argv1 == "scan_port_specific"
	require_all
	require_root
	scan_specific
elsif argv1 == "help"
	display_help
elsif argv1 == "scan_all_ports" || argv1 == "scan_all"
	require_all
	scan_all_ports
elsif argv1 == "ip_scan" || argv1 == "scan_ip"
	require_all
	ip_scan
elsif argv1 == "scan_service" || argv1 == "service_scan"
	require_all
	scan_services
elsif argv1 == "ping_of_death" || argv1 == "death_ping"
	require_all
	ping_of_death
else
	puts 'invalid command'
end
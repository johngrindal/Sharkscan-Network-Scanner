#MAIN SHARKSCAN SCRIPT
#CREATED BY JOHN GRINDAL
#BITBUCKET --- https://bitbucket.org/Sharkscan_Development/

#encoding: utf-8

def check_gem # --- CHECK FOR MISSING GEMS
  begin
	  gem 'em-websocket'
  rescue Gem::LoadError
	  puts "IT APPEARS YOU ARE MISSING THE SOCKET GEM"
    puts "TO INSTALL IT TYPE 'gem install em-websocket'"
	else
		#donothing
	end

	begin
		gem 'net-ping', '>=1.7.8'
	rescue Gem::LoadError
		puts "IT APPEARS THAT YOU ARE MISSING THE NET-PING GEM"
    puts "TO INSTALL IT TYPE 'gem install net-ping'"
	else
		#donothing
	end
end


def require_all # --- REQUIRE ALL GEMS
  require 'socket'
  require 'net/ping'
  require 'timeout'
end

def check_root
  if ENV["USER"] != "root"
    abort("PLEASE RUN SHARKSCAN AS ROOT")
	end
end

def install_dependencies
  system("clear")
  puts "INSTALL MISSING DEPENDENCIES"
  puts "\n"
  puts "\n"
  print "WOULD YOU LIKE TO INSTALL DEPENDENCIES  Y/N:"
  install = STDIN.gets.chomp
  if install == "y" || install == "yes" || install == "Y"  || install == "YES"
    system("clear")
    puts "INSTALLING DEPENDENCIES..."
    system("gem install em-websocket")
    system("gem install net-ping")
  else
    abort("exiting...")
  end
end

def banner_grabber # -- GRAB BANNERS THROUGH TELNET
  system("clear")
  puts "BANNER GRABBER"
  puts "\n"
  puts "\n"
  print "ENTER YOUR TARGET:"
  target = STDIN.gets.chomp
  port = 0
  openports = Array.new
  openports_length = 0
  until port == 1000 do
  	begin
  		TCPSocket.new(target, port)
  	rescue
	  	#donothing
	  else
	  	openports.push(port)
	  	openports_length += 1
  	end
	  	port += 1
  end

  until openports_length == 0 do
  	system("telnet #{target} #{openports[openports_length]}")
	  puts "\n"
	  puts "\n"
	  openports_length -= 1
  end
end


def ping_scan # --- SCAN NETWORK FOR HOSTS
  system("clear")
  system("clear")
  puts "PING SCAN"
  puts "\n"
  puts "\n"
  puts "ENTER THE PREFIX FOR YOUR NETWORK"
  puts "EXAMPLE: (192.168.0.)"
  puts "\n"
  print "PREFIX:"
  prefix = STDIN.gets.chomp
  marker = 0
  ip = 0
  system("clear")
  puts "SCANNING..."
	range = 225
	start_num = 0
	(1..range).each do
    start_num += 1
  	ip = "#{prefix}#{start_num}"
  	@icmp = Timeout::timeout(1){Net::Ping::ICMP.new(ip)}
  	if @icmp.ping
  		puts "#{ip}"
    else
      #donothing
    end
  end
end

def scan_specific_port # --- SCAN A SPECIFIC PORT TO SEE IF IT IS OPEN
  system("clear")
  puts "SCAN A SPECIFIC PORT"
  puts "\n"
  puts "\n"
  print "ENTER YOUR TARGET ADDRESS:"
  target = STDIN.gets.chomp
  print "ENTER THE PORT YOU WANT TO SCAN:"
  port = STDIN.gets.chomp
  system("clear")
  begin
    TCPSocket.new(target, port)
  rescue
    puts "PORT #{port} APPEARS TO BE CLOSED"
  else
    puts "PORT #{port} APPEARS TO BE OPEN"
  end
end


def service_scan # --- SCAN A TARGET FOR KNOWN SERVICES
  system("clear")
  puts "SCAN FOR SERVICES"
  puts "\n"
  puts "\n"
  print 'ENTER AN IP TO SCAN:'
  ip = STDIN.gets.chomp
  names = Array.new
  ports = ["161","162","80","443","458","118","156","109","110","115","53","22","1900","23","7","20","445"]
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


def port_scan # --- SCAN ALL PORTS ON A TARGET
  system("clear")
  puts "SCAN ALL PORTS"
  puts "\n"
  puts "\n"
  print "ENTER YOUR TARGETS IP:"
  ip = STDIN.gets.chomp
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


def ping_of_death # --- SEND MALFORMED PACKETS TO TARGET, MAY HARM TARGET
  system("clear")
  puts "PING OF DEATH"
  puts "\n"
  puts "\n"
  puts "WARNING THIS MAY HARM THE TARGET"
  print "TARGET IP:"
  ip = STDIN.gets.chomp

  #send ping
  os.system("ping -l 65510 #{ip}")
  puts "SENDING MORE PACKETS..."
  os.system("ping -l 100000 #{ip}")
  puts "DONE."
end

def help # --- JUST THAT DEFAULT HELP MESSAGE
  puts "####USAGE####"
  puts "\n"
  puts "\n"
  puts "\n"
  puts "BANNER_GRABBER --- EXTRACT BANNERS USING TELNET"
  puts "\n"
  puts "SCAN_PORTS --- SCAN ALL PORTS TO SEE WHICH ONES ARE OPEN"
  puts "\n"
  puts "PING_OF_DEATH --- SEND MALFORMED PACKETS TO TARGET, MAY HARM MACHINE"
  puts "\n"
  puts "PING_SCAN --- DO A PING SWEEP OF THE NETWORK"
  puts "\n"
  puts "SCAN_SPECIFIC_PORT --- SCAN A SPECIFIC PORT TO SEE OF IT IS OPEN"
  puts "\n"
  puts "INSTALL_DEPENDENCIES --- INSTALL ANY MISSING DEPENDENCIES"
  puts "\n"
end



#REDIRECTOR
check_gem
check_root
argument = ARGV.first

if argument == "SCAN_SPECIFIC_PORT" || argument == "scan_specific_port"
  require_all
  scan_specific_port
elsif argument == "BANNER_GRABBER" || argument == "banner_grabber"
  require_all
  banner_grabber
elsif argument == "PING_OF_DEATH" || argument == "ping_of_death"
  require_all
  ping_of_death
elsif argument == "PING_SCAN" || argument == "ping_scan"
  require_all
  ping_scan
elsif argument == "SERVICE_SCAN" || argument == "service_scan"
  require_all
  service_scan
elsif argument == "INSTALL_DEPENDENCIES" || argument == "install_dependencies"
  require_all
  install_dependencies
elsif argument == "SCAN_PORTS" || argument == "scan_ports"
  require_all
  port_scan
elsif argument == "HELP" || argument == "help"
  help
else
  puts "INVALID COMMAND"
  puts "\n"
  puts "TYPE HELP FOR MORE INFORMATION"
end





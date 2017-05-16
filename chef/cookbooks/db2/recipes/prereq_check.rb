#
# Cookbook Name:: db2
# Recipe:: prereq_check
#
# Copyright IBM Corp. 2017, 2017
#
# <> Prerequisites check recipe (prereq_check.rb)
# <> Recipe to ensure that pre-requisites are in place for a cookbook to run.

# Validations:
Chef::Log.info("Checking supported DB2 version")
raise "DB2 version #{node['db2']['version']} not supported" unless node['db2']['supported_versions'].include? node['db2']['version']
Chef::Log.info("PASS: DB2 Version is: #{node['db2']['version']}")

unless node['db2']['database'].empty?
  node['db2']['database'].each_pair do |_db, p|
    raise "database name is limited to 8 character" if p['db_name'].length > 8
  end
end

raise "Package for DB2 version #{node['db2']['version']} not included in ['db2']['archive_names'] hash in internal.rb file" unless node['db2']['archive_names'].keys.find { |k| k.include? node['db2']['version'] }

# https://www.ibm.com/support/knowledgecenter/beta/SSEPGG_10.5.0/com.ibm.db2.luw.qb.server.doc/doc/t0008238.html
raise "The value of kernel_sem_SEMMSL is lower than 250" if node['db2']['kernel_sem_SEMMSL'].to_i < 250
raise "The value of kernel_sem_SEMMNI is lower than #{256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024}" if node['db2']['kernel_sem_SEMMNI'].to_i < 256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024
raise "The value of kernel_sem_SEMMNS' is lower than 256000" if node['db2']['kernel_sem_SEMMNS'].to_i < 256_000
raise "The value of kernel_sem_SEMOPM is lower than 32" if node['db2']['kernel_sem_SEMOPM'].to_i < 32

raise "The value of kernel.msgmni is lower than #{node['memory']['total'].sub(/kb/i, '').to_i / 1024}" if node['db2']['kernel']['kernel.msgmni'].to_i < node['memory']['total'].sub(/kb/i, '').to_i / 1024
raise "The value of kernel.msgmax is lower than 65536" if node['db2']['kernel']['kernel.msgmax'].to_i < 65_536
raise "The value of kernel.msgmnb is lower than 65536" if node['db2']['kernel']['kernel.msgmnb'].to_i < 65_536
raise "The value of kernel.shmmni is lower than #{256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024}" if node['db2']['kernel']['kernel.shmmni'].to_i < 256 * node['memory']['total'].sub(/kb/i, '').to_i / 1024 / 1024
raise "The value of kernel.shmall is lower than #{2 * shell_out!('getconf PAGESIZE').stdout.to_i * 1024}" if node['db2']['kernel']['kernel.shmall'].to_i < 2 * shell_out!("getconf PAGESIZE").stdout.to_i * 1024
case node['kernel']['name']
when 'Linux'
  case node['kernel']['machine']
  when 'i386'
    raise "On 32-bit Linux operating systems, the enforced minimum setting for SHMMAX is limited to 4 294 967 295 bytes" if node['db2']['kernel']['kernel.shmmax'].to_i > 4_294_967_295
  end
end
raise "The value of kernel.shmmax is lower than #{node['memory']['total'].sub(/kb/i, '').to_i * 1024}" if node['db2']['kernel']['kernel.shmmax'].to_i < node['memory']['total'].sub(/kb/i, '').to_i * 1024

version = node['db2']['version'] + '.0.'+ node['db2']['included_fixpack']

node['db2']['archive_names'].each_pair do |p, v|
  next if p.to_s != version
  filename = v['filename']
  Chef::Log.info("Checking if file #{filename} exists")
  ruby_block "base_packages_validation" do
    block do
      require 'net/http'
      require 'openssl'
      encrypted_id = node['db2']['vault']['encrypted_id']
      chef_vault = node['db2']['vault']['name']
      repo_user = node['ibm']['repo_user']
      repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['repo_password']
      uri = URI.parse(node['ibm']['sw_repo_root'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if node['ibm']['sw_repo_root'].include? "https"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if node['ibm']['sw_repo_self_signed_cert'] == "true"
      request = Net::HTTP::Head.new(node['db2']['sw_repo_path'] + '/' + filename)
      request.basic_auth(repo_user, repo_password) if node['ibm']['sw_repo_auth'] == "true" # ~password_checker
      begin
        res = http.request(request)
      rescue OpenSSL::SSL::SSLError
        raise "Self signed certificate detected when trying to access #{node['ibm']['sw_repo_root']}. Please use sw_repo_self_signed_cert == \"true\" "
      end
      print "\n HTTP response code is #{res.code} \n"
      print "\n =========== Package #{filename} is there! ============ \n" if res.code == "200"
      raise "#{res.code} Bad Request. The request could not be understood by the server due to malformed syntax." if res.code == "400"
      raise "#{res.code} Unauthorized. The request requires user authentication." if res.code == "401"
      raise "#{res.code} Please make sure your DB2 package is available in your binary repository" if res.code == "404"
    end
    not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end
end

node['db2']['fixpack_names'].each_pair do |p, v|
  next if p.to_s != node['db2']['version'] || node['db2']['fixpack'] == "0"
  fp_filename = v['filename']
  Chef::Log.info("Checking if file #{fp_filename} exists")
  ruby_block "fixpack_packages_validation" do
    block do
      require 'net/http'
      require 'openssl'
      encrypted_id = node['db2']['vault']['encrypted_id']
      chef_vault = node['db2']['vault']['name']
      repo_user = node['ibm']['repo_user']
      repo_password = chef_vault_item(chef_vault, encrypted_id)['ibm']['repo_password']
      uri = URI.parse(node['ibm']['sw_repo_root'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if node['ibm']['sw_repo_root'].include? "https"
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE if node['ibm']['sw_repo_self_signed_cert'] == "true"
      request = Net::HTTP::Head.new(node['db2']['fp_repo_path'] + '/' + fp_filename)
      request.basic_auth(repo_user, repo_password) if node['ibm']['sw_repo_auth'] == "true" # ~password_checker
      begin
        res = http.request(request)
      rescue OpenSSL::SSL::SSLError
        raise "Self signed certificate detected when trying to access #{node['ibm']['sw_repo_root']}. Please use sw_repo_self_signed_cert == \"true\" "
      end
      print "\n HTTP response code is #{res.code} \n"
      print "\n =========== Package #{fp_filename} is there! ============ \n" if res.code == "200"
      raise "#{res.code} Bad Request. The request could not be understood by the server due to malformed syntax." if res.code == "400"
      raise "#{res.code} Unauthorized. The request requires user authentication." if res.code == "401"
      raise "#{res.code} Please make sure your DB2 fixpack package is available in your binary repository" if res.code == "404"
    end
    not_if { db2_fp_installed?(node['db2']['install_dir'], node['db2']['fixpack']) }
  end
end

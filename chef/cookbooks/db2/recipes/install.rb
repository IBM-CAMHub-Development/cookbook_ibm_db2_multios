#
# Cookbook Name:: db2
# Recipe:: install
#
# Copyright IBM Corp. 2017, 2017
#
# <> Installation recipe (install.rb)
# <> This recipe performs the product installation.

version = node['db2']['base_version']

node['db2']['archive_names'].each_pair do |p, v|
  next if p.to_s != version
  filename = v['filename']
  sha256 = v['sha256']
  Chef::Log.info("Unpacking #{filename}...")

  ibm_cloud_utils_unpack "unpack-#{filename}" do
    source "#{node['ibm']['sw_repo']}#{node['db2']['sw_repo_path']}/#{filename}"
    target_dir node['db2']['expand_area']
    checksum sha256
    remove_local true
    vault_name node['db2']['vault']['name']
    vault_item node['db2']['vault']['encrypted_id']
    repo_self_signed_cert node['ibm']['sw_repo_self_signed_cert']
    not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
  end
end

execute 'Install db2' do
  cwd node['db2']['base_dir']
  command "./db2setup -l #{node['ibm']['log_dir']}/DB2_install.log -r #{node['db2']['expand_area']}/db2_install.rsp"
  not_if { db2_installed?(node['db2']['install_dir'], node['db2']['version']) }
end

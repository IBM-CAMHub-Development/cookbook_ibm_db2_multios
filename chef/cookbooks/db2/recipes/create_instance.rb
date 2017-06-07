#
# Cookbook Name:: db2
# Recipe:: create_instance
#
# Copyright IBM Corp. 2017, 2017
#
# <> create instance recipe (create_instance.rb)
# <> This recipe creates new db2 instances.

raise "db2 instance hash is empty. Please add a set of values for the new instance." if node['db2']['instance'].empty?
node['db2']['instance'].each_pair do |inst_key, p|

  inst_password = instance_password(inst_key, p['instance_username'])
  fenc_password = fenced_password(inst_key, p['fenced_username'])

  db2_instance p['instance_username'] do
    instance_prefix p['instance_prefix']
    instance_type p['instance_type']
    instance_username p['instance_username']
    instance_groupname p['instance_groupname']
    instance_password inst_password
    instance_dir p['instance_dir']
    port p['port']
    fenced_username p['fenced_username']
    fenced_groupname p['fenced_groupname']
    fenced_password fenc_password
    fcm_port p['fcm_port']
    action :create
  end
end

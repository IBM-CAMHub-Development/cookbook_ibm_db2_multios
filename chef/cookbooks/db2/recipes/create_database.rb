#
# Cookbook Name:: db2
# Recipe:: create_database
#
# Copyright IBM Corp. 2017, 2017
#
# <> create database recipe (create_database.rb)
# <> This recipe creates new db2 databases.

# Match groupname from instance
instance_username = ''
instance_groupname = ''

node['db2']['database'].each_pair do |_db, p|
  instance_username = p['instance_username']
end

node['db2']['instance'].each_pair do |_i, d|
  next unless instance_username == d['instance_username'] # match instance with same user
  instance_groupname = d['instance_groupname']
end

raise "db2 name hash is empty. Please add a set of values for the new database." if node['db2']['database'].empty?
node['db2']['database'].each_pair do |_db, p|
  db2_database p['db_name'] do
    instance_username instance_username
    instance_groupname instance_groupname
    db_name p['db_name']
    db_data_path p['db_data_path']
    db_path p['db_path']
    pagesize p['pagesize']
    territory p['territory']
    codeset p['codeset']
    db_collate p['db_collate'].to_s.upcase
    action :create
  end
end

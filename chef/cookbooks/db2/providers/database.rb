#
# Cookbook Name:: db2
# Provider:: db2_database
#
# Copyright IBM Corp. 2017, 2017
#
include DB2::Helper
use_inline_resources

action :create do
  if @current_resource.db2_database_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  elsif @current_resource.db2_instance_created
    converge_by("Install #{@new_resource}") do
      raise "db2 name is limited to 8 character" if new_resource.db_name.length > 8
      execute "create database(#{new_resource.db_name})" do
        command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 'create database #{new_resource.db_name} ON #{new_resource.db_data_path} DBPATH ON #{new_resource.db_path} USING CODESET #{new_resource.codeset} TERRITORY #{new_resource.territory} PAGESIZE #{new_resource.pagesize}' > #{new_resource.log_dir}/db2_create_database_#{new_resource.db_name}.log\""
      end
    end
  else
    raise "DB2 instance #{@new_resource.instance_username} does not exist. Please use the right instance or create #{@new_resource.instance_username} instance first"
  end
end

#Override Load Current Resource
def load_current_resource
  @current_resource = Chef::Resource::Db2Database.new(@new_resource.name)
  #A common step is to load the current_resource instance variables with what is established in the new_resource.
  #What is passed into new_resouce via our recipes, is not automatically passed to our current_resource.
  @current_resource.db_name(@new_resource.db_name)
  @current_resource.db2_install_dir(@new_resource.db2_install_dir)
  @current_resource.instance_username(@new_resource.instance_username)

  #Get current state
  @current_resource.db2_database_created = db2_database_created?(@new_resource.db_name, @new_resource.db2_install_dir, @new_resource.instance_username)
  @current_resource.db2_instance_created = db2_instance_created?(@new_resource.db2_install_dir, @new_resource.instance_username)
end

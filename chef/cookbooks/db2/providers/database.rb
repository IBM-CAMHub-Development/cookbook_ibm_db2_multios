#
# Cookbook Name:: db2
# Provider:: db2_database
#
# Copyright IBM Corp. 2017, 2017
#
# ::Chef::Resource.send(:include, DB2::Helper)
include DB2::Helper
include DB2::OS
use_inline_resources

action :create do
  if @current_resource.db2_database_created
    Chef::Log.info "#{@new_resource} already exists - nothing to do."
  elsif @current_resource.db2_instance_created
    converge_by("Install #{@new_resource}") do
      raise "db2 name is limited to 8 character" if new_resource.db_name.length > 8

      # create directories
      subdirs, reason = subdirs_to_create(new_resource.db_data_path, new_resource.instance_username)
      raise reason unless reason.empty?
      subdirs.each do |dir|
        directory "create db_data_path: #{dir}" do
          path dir
          action :create
          owner new_resource.instance_username
          group new_resource.instance_groupname
          recursive true
        end
      end

      unless new_resource.db_path.empty? || new_resource.db_path == new_resource.db_data_path
        subdirs, reason = subdirs_to_create(new_resource.db_path, new_resource.instance_username)
        raise reason unless reason.empty?
        subdirs.each do |dir|
          directory "create db_path: #{dir}" do
            path dir
            action :create
            owner new_resource.instance_username
            group new_resource.instance_groupname
            recursive true
          end
        end
      end
     
      # compose command line
      cmd = "create database #{new_resource.db_name} ON #{new_resource.db_data_path}"
      cmd += " DBPATH ON #{new_resource.db_path}" unless new_resource.db_path.empty? || new_resource.db_path == new_resource.db_data_path
      cmd += " USING CODESET #{new_resource.codeset}" unless new_resource.codeset.empty?
      cmd += " TERRITORY #{new_resource.territory}" unless new_resource.territory.empty?
      cmd += " COLLATE USING #{new_resource.db_collate}" unless new_resource.db_collate.empty?
      cmd += " PAGESIZE #{new_resource.pagesize}" unless new_resource.pagesize.empty?
      execute "Create database(#{new_resource.db_name})" do
        command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 '#{cmd}' | tee -a ~/db2_create_database_#{new_resource.db_name}.log\""
      end
      execute "Save log for #{new_resource.db_name}" do
        command "mv #{Etc.getpwnam(new_resource.instance_username).dir}/db2_create_database_#{new_resource.db_name}.log #{node['ibm']['log_dir']}"
      end
    end

    # update database
    # this is 'install only', updates on prod db should not be performed without proper backup configuration
    unless new_resource.database_update.empty?
      dummy_backup = false
      new_resource.database_update.each_pair do |option, value|
        next if value.casecmp('default').zero?
        dummy_backup = true
        if option.casecmp('NEWLOGPATH').zero? || option.casecmp('FAILARCHPATH').zero?
          subdirs, _reason = subdirs_to_create(value, new_resource.instance_username)
          # raise reason unless reason.empty?
          subdirs.each do |dir|
            directory "create #{option}: #{dir}" do
              path dir
              action :create
              owner new_resource.instance_username
              group new_resource.instance_groupname
              recursive true
            end
          end
        end
        execute "Update #{new_resource.db_name} using #{option} = #{value}" do
          command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 UPDATE DB CFG FOR #{new_resource.db_name} USING #{option} #{value} DEFERRED\""
        end
      end

      # perform dummy backup to enable updates
      execute "Perform dummy backup #{new_resource.db_name} to enable updates" do
        command "su - #{new_resource.instance_username} -s /bin/bash -c \"db2 BACKUP DB #{new_resource.db_name} TO /dev/null\""
        only_if { dummy_backup }
      end
      
      # ... and restart instance
      db2_service "Stop instance #{new_resource.instance_username}" do
        instance_username new_resource.instance_username
        action :stop_instance
      end
      db2_service "Start instance #{new_resource.instance_username}" do
        instance_username new_resource.instance_username
        action :start_instance
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

name             'db2'
maintainer       'IBM Corp'
maintainer_email ''
license          'Copyright IBM Corp. 2017, 2017'
depends          'ibm_cloud_utils'
depends          'linux'
version '0.1.44'
description <<-EOH
## DESCRIPTION
The db2 cookbook contains features and functions to support the installation, configuration, and management of IBM DB2.
## Platforms Support
* RHEL 6.x or greater
* Ubuntu Server 14.04 or greater
## Versions
* IBM DB2 V10.5 (except on Ubuntu 16+)
* IBM DB2 V11.1
## Use Cases
* Single installation with no configuration.
* Single installation with 1..n instances defined.
* Single installation with 1..n instances defined and 1..n databases defined for each instance
## Platform Pre-Requisites
* OS Package Repository - Access to a linux yum/apt repository is required.
## Software Repository
SW_REPO_ROOT -> Stored in the ['ibm']['sw_repo'] attribute.
Relative to the software repository, the installation files must be stored in the following location.
* BASE FILES   -> /db2/v105/base
* FIXPACK FILES -> /db2/v105/maint
The following is a description of files needed on the REPO Server depending on version and architecture.
```python
case node['platform_family']
when 'rhel'
  case node['kernel']['machine']
  when 'x86_64'
    default['db2']['arch'] = 'x86-64'
    # <> DB2 Version 10.5.0.3, 10.5.0.8
    force_override['db2']['archive_names'] = {
      '10.5.0.3' => { 'filename' => 'DB2_Svr_' + node['db2']['base_version'] + '.' + node['db2']['included_modpack'] + '.'+ node['db2']['included_fixpack'] + '_Linux_' + node['db2']['arch'] + '.tar.gz',
                      'sha256' => 'd5844d395c66470f39db13ba2491b2036c2d6b50e89c06d46f3d83f4b6f093a7' },
      '10.5.0.8' => { 'filename' => 'DB2_Svr_' + node['db2']['version'] + '.' + node['db2']['included_modpack'] + '.'+ node['db2']['included_fixpack'] + '_Linux_' + node['db2']['arch'] + '.tar.gz',
                      'sha256' => '79233751b83a0acde01b84bbd506b8fe917a29a4ed08852ae821090ce2fc0256' },
      '11.1.0.0' => { 'filename' => 'DB2_Svr_' + node['db2']['version'] + '_Linux_' + node['db2']['arch'] + '.tar.gz', #~ip_checker
                      'sha256' => '635f1b64eb48ecfd83aface91bc4b99871f12b7d5c41e7aa8f8b3d275bcb7f04' }
    }
    # <> DB2 Fixpack package
    force_override['db2']['fixpack_names'] = {
      '10.5'  => { 'filename' => 'v' + node['db2']['version'] + 'fp' + node['db2']['fixpack'] + '_linuxx64_server_t.tar.gz' },
      '11.1'  => { 'filename' => 'v' + node['db2']['version']+ '.' + node['db2']['modpack'] + 'fp' + node['db2']['fixpack'] + '_linuxx64_server_t.tar.gz' }
    }
  end
end
```
EOH
attribute 'db2/base_version',
          :choice => ['10.5.0.3', '10.5.0.8', '11.1.0.0', 'none'],
          :default => '10.5.0.8',
          :description => 'The base version of DB2 to install. Set to none if installing from fix package.',
          :displayname => 'DB2 base version',
          :options => ['10.5.0.3', '10.5.0.8', '11.1.0.0', 'none'],
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/das_password',
          :default => '',
          :description => 'DB2 Administration Server (DAS) password',
          :displayname => 'Password (DAS username)',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/das_username',
          :default => 'dasadm1',
          :description => 'DB2 Administration Server (DAS) username',
          :displayname => 'DAS username',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/fp_version',
          :default => '10.5.0.8',
          :description => 'The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version.',
          :displayname => 'DB2 fix pack version',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/install_dir',
          :choice => ['/opt/ibm/db2/V10.5', '/opt/ibm/db2/V11.1'],
          :default => '/opt/ibm/db2/V10.5',
          :description => 'The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version>',
          :displayname => 'DB2 installation directory',
          :options => ['/opt/ibm/db2/V10.5', '/opt/ibm/db2/V11.1'],
          :parm_type => 'component',
          :precedence_level => 'role',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'true',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/codeset',
          :default => 'UTF-8',
          :description => 'Codeset is used by the database manager to determine codepage parameter values.',
          :displayname => 'Codeset',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/FAILARCHPATH',
          :default => 'default',
          :description => 'The path to be used for archiving log files.',
          :displayname => 'Failover log archive path',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGARCHMETH1',
          :default => 'default',
          :description => 'Specifies the media type of the primary destination for logs that are archived.',
          :displayname => 'Primary log archive method',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGFILSIZ',
          :default => 'default',
          :description => 'Specifies the size of log files.',
          :displayname => 'Log file size',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGSECOND',
          :default => 'default',
          :description => 'Specifies the number of secondary log files that are created and used for recovery log files.',
          :displayname => 'Number of secondary log files',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/NEWLOGPATH',
          :default => 'default',
          :description => 'The path to be used for database logging.',
          :displayname => 'Database log path',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/ldap_user',
          :default => 'false',
          :description => 'Specifies if user is in LDAP.',
          :displayname => 'LDAP user',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_access',
          :default => 'none',
          :description => 'Database access to be granted. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL',
          :displayname => 'Database user access',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_gid',
          :default => 'grp1',
          :description => 'Specifies the name of the Operating System group for database users.',
          :displayname => 'User group name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_home',
          :default => 'default',
          :description => 'The database user home directory.',
          :displayname => 'Database user home directory',
          :parm_type => 'none',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_name',
          :default => 'user1',
          :description => 'A user name to be granted database access.',
          :displayname => 'User name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_password',
          :default => '',
          :description => 'The password for the datbase user name',
          :displayname => 'Password (User name)',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_collate',
          :default => 'SYSTEM',
          :description => 'Collate determines ordering for a set of characters.',
          :displayname => 'Collate',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_data_path',
          :default => '/home/db2inst1',
          :description => 'Specifies the DB2 database data path.',
          :displayname => 'DB2 database data path',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_name',
          :default => 'db01',
          :description => 'The name of the database to be created.',
          :displayname => 'Database name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_path',
          :default => '/home/db2inst1',
          :description => 'Specifies the DB2 database path.',
          :displayname => 'DB2 database path',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/instance_username',
          :default => 'db2inst1',
          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
          :displayname => 'DB2 instance username',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/pagesize',
          :default => '4096',
          :description => 'Specifies the page size in bytes.',
          :displayname => 'Page size',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/territory',
          :default => 'US',
          :description => 'Territory is used by the database manager when processing data that is territory sensitive.',
          :displayname => 'Territory',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fcm_port',
          :default => '60000',
          :description => 'The port for the DB2 Fast Communications Manager (FCM).',
          :displayname => 'DB2 FCM port',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_groupname',
          :default => 'db2fenc1',
          :description => 'The group name for the DB2 fenced user.',
          :displayname => 'DB2 fenced group name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_password',
          :default => '',
          :description => 'The password for the DB2 fenced username.',
          :displayname => 'Password (DB2 fenced username)',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/fenced_username',
          :default => 'db2fenc1',
          :description => 'The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database.',
          :displayname => 'DB2 fenced username',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_dir',
          :default => '/home/db2inst1',
          :description => 'The DB2 instance directory stores all information that pertains to a database instance.',
          :displayname => 'DB2 instance directory',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_groupname',
          :default => 'db2iadm1',
          :description => 'The group name for the DB2 instance user.',
          :displayname => 'DB2 instance group name',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_password',
          :default => '',
          :description => 'The password for the DB2 instance username.',
          :displayname => 'Password (DB2 instance username)',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'true',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_prefix',
          :default => 'DB2_INST',
          :description => 'Specifies the DB2 instance prefix',
          :displayname => 'DB2 instance prefix',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_type',
          :default => 'ESE',
          :description => 'The type of DB2 instance to create.',
          :displayname => 'DB2 instance type',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/instance_username',
          :default => 'db2inst1',
          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
          :displayname => 'DB2 instance username',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
attribute 'db2/instances/instance($INDEX)/port',
          :default => '50000',
          :description => 'The port to connect to the DB2 instance.',
          :displayname => 'DB2 connection port',
          :parm_type => 'node',
          :precedence_level => 'node',
          :required => 'recommended',
          :secret => 'false',
          :selectable => 'false',
          :type => 'string'
recipe 'db2::cleanup.rb', '
Cleanup recipe (cleanup.rb)
This recipe will remove any temporary installation files created as part of the automation.
'
recipe 'db2::create_db.rb', '
Create database recipe (create_db.rb)
This recipe will create instances and databases as specified in attributes.
'
recipe 'db2::default.rb', '
Default recipe (default.rb)
The default recipe for the cookbook. It is recommended to not use the default recipe, but explicitly specify a run_list for the deployment node.
'
recipe 'db2::fixpack.rb', '
Fixpack recipe (fixpack.rb)
This recipe performs product fixpack installation.
'
recipe 'db2::gather_evidence.rb', '
Evidence gathering recipe (gather_evidence.rb)
This recipe will collect functional product information and store it in an archive.
'
recipe 'db2::harden.rb', '
Product hardening recipe (harden.rb)
This recipe performs security hardening tasks.
'
recipe 'db2::install.rb', '
Installation recipe (install.rb)
This recipe performs the product installation.
'
recipe 'db2::license.rb', '
License recipe (license.rb)
This recipe will apply the license file from a repo server, in case a base package cannot be installed.
'
recipe 'db2::prereq.rb', '
Prerequisite recipe (prereq.rb)
This recipe configures the operating prerequisites for the product.
'
recipe 'db2::prereq_check.rb', '
Prerequisites check recipe (prereq_check.rb)
Recipe to ensure that pre-requisites are in place for a cookbook to run.
'

#
# Cookbook Name:: db2
# attributes :: default
#
# Copyright IBM Corp. 2017, 2017

# <> DB2 base package version
# <md>attribute 'db2/base_version',
# <md>          :displayname => 'DB2 base version',
# <md>          :description => 'The base version of DB2 to install. Set to none if installing from fix package.',
# <md>          :choice => [ '10.5.0.3', '10.5.0.8', '11.1.0.0', 'none' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10.5.0.8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['base_version'] = '10.5.0.8'

# <> DB2 fixpack version
# <md>attribute 'db2/fp_version',
# <md>          :displayname => 'DB2 fix pack version',
# <md>          :description => 'The version of DB2 fix pack to install. If no fix pack is required, set this value the same as DB2 base version.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10.5.0.8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['fp_version'] = node['db2']['base_version']

# <> The DB2 installation directory
# <md>attribute 'db2/install_dir',
# <md>          :displayname => 'DB2 installation directory',
# <md>          :description => 'The directory to install DB2. Recommended: /opt/ibm/db2/V<db2_version>',
# <md>          :choice => [ '/opt/ibm/db2/V10.5',
# <md>                       '/opt/ibm/db2/V11.1' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/ibm/db2/V10.5',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :parm_type => 'component',
# <md>          :secret => 'false'
default['db2']['install_dir'] = '/opt/ibm/db2/V' + node['db2']['fp_version'].split('.')[0, 2].join('.')

## das server
# <> DB2 Administration Server (DAS) username
# <md>attribute 'db2/das_username',
# <md>          :displayname => 'DAS username',
# <md>          :description => 'DB2 Administration Server (DAS) username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'dasadm1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['das_username'] = 'dasadm1'

# <> DB2 Administration Server (DAS) password
# <md>attribute 'db2/das_password',
# <md>          :displayname => 'Password (DAS username)',
# <md>          :description => 'DB2 Administration Server (DAS) password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'
default['db2']['das_password'] = ''

# <> DB2 instance attribute
# <md>attribute '$dynamicmaps/db2/instances'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 instances',
# <md>          :$key => 'instance',
# <md>          :$max => '4'
# <md>attribute '$dynamicmaps/db2/instances/instance($INDEX)/$dynamicmaps/databases'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 databases',
# <md>          :$key => 'database',
# <md>          :$max => '4'
# <md>attribute '$dynamicmaps/db2/instances/instance($INDEX)/$dynamicmaps/databases/database($INDEX)/$dynamicmaps/database_users'
# <md>          :$count => '0',
# <md>          :$displayname => 'DB2 database users',
# <md>          :$key => 'db_user',
# <md>          :$max => '4'

# <md>attribute 'db2/instances/instance($INDEX)/instance_prefix',
# <md>          :displayname => 'DB2 instance prefix',
# <md>          :description => 'Specifies the DB2 instance prefix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'DB2_INST',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_type',
# <md>          :displayname => 'DB2 instance type',
# <md>          :description => 'The type of DB2 instance to create.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ESE',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_username',
# <md>          :displayname => 'DB2 instance username',
# <md>          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_groupname',
# <md>          :displayname => 'DB2 instance group name',
# <md>          :description => 'The group name for the DB2 instance user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2iadm1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_password',
# <md>          :displayname => 'Password (DB2 instance username)',
# <md>          :description => 'The password for the DB2 instance username.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/instance_dir',
# <md>          :displayname => 'DB2 instance directory',
# <md>          :description => 'The DB2 instance directory stores all information that pertains to a database instance.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/port',
# <md>          :displayname => 'DB2 connection port',
# <md>          :description => 'The port to connect to the DB2 instance.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '50000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_username',
# <md>          :displayname => 'DB2 fenced username',
# <md>          :description => 'The fenced user is used to run user defined functions and stored procedures outside of the address space used by the DB2 database.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_groupname',
# <md>          :displayname => 'DB2 fenced group name',
# <md>          :description => 'The group name for the DB2 fenced user.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_password',
# <md>          :displayname => 'Password (DB2 fenced username)',
# <md>          :description => 'The password for the DB2 fenced username.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/fcm_port',
# <md>          :displayname => 'DB2 FCM port',
# <md>          :description => 'The port for the DB2 Fast Communications Manager (FCM).',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '60000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <> DB2 Databse
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_name',
# <md>          :displayname => 'Database name',
# <md>          :description => 'The name of the database to be created.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db01',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_data_path',
# <md>          :displayname => 'DB2 database data path',
# <md>          :description => 'Specifies the DB2 database data path.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_path',
# <md>          :displayname => 'DB2 database path',
# <md>          :description => 'Specifies the DB2 database path.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/instance_username',
# <md>          :displayname => 'DB2 instance username',
# <md>          :description => 'The DB2 instance username controls all DB2 processes and owns all filesystems and devices.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/pagesize',
# <md>          :displayname => 'Page size',
# <md>          :description => 'Specifies the page size in bytes.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/territory',
# <md>          :displayname => 'Territory',
# <md>          :description => 'Territory is used by the database manager when processing data that is territory sensitive.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'US',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/codeset',
# <md>          :displayname => 'Codeset',
# <md>          :description => 'Codeset is used by the database manager to determine codepage parameter values.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'UTF-8',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_collate',
# <md>          :displayname => 'Collate',
# <md>          :description => 'Collate determines ordering for a set of characters.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'SYSTEM',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# Database parameters to be set by an UPDATE command
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/NEWLOGPATH',
# <md>          :displayname => 'Database log path',
# <md>          :description => 'The path to be used for database logging.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/FAILARCHPATH',
# <md>          :displayname => 'Failover log archive path',
# <md>          :description => 'The path to be used for archiving log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGARCHMETH1',
# <md>          :displayname => 'Primary log archive method',
# <md>          :description => 'Specifies the media type of the primary destination for logs that are archived.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGFILSIZ',
# <md>          :displayname => 'Log file size',
# <md>          :description => 'Specifies the size of log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_update/LOGSECOND',
# <md>          :displayname => 'Number of secondary log files',
# <md>          :description => 'Specifies the number of secondary log files that are created and used for recovery log files.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# Users to be granted access to the database (user_access = none -> user is created but no access is granted)
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_name',
# <md>          :displayname => 'User name',
# <md>          :description => 'A user name to be granted database access.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'user1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_gid',
# <md>          :displayname => 'User group name',
# <md>          :description => 'Specifies the name of the Operating System group for database users.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'grp1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_password',
# <md>          :displayname => 'Password (User name)',
# <md>          :description => 'The password for the datbase user name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_home',
# <md>          :displayname => 'Database user home directory',
# <md>          :description => 'The database user home directory.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'default',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'none',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/ldap_user',
# <md>          :displayname => 'LDAP user',
# <md>          :description => 'Specifies if user is in LDAP.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'false',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/database_users/db_user($INDEX)/user_access',
# <md>          :displayname => 'Database user access',
# <md>          :description => 'Database access to be granted. Example: DBADM WITH DATAACCESS WITHOUT ACCESSCTRL',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'none',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

default['db2']['instances'] = {}
# Sample instance attribute. This will be set in role file
#default['db2']['instances'] = {
#  'inst1' => {
#    'instance_prefix' => 'DB2_INS1',
#    'instance_type' => 'ESE',
#    'instance_username' => 'db2inst1',
#    'instance_groupname' => 'db2iadm1',
#    'instance_password' => 'passw0rd',
#    'instance_dir' => '/home/db2inst1',
#    'port' => '50000',
#    'fenced_username' => 'db2fenc1',
#    'fenced_groupname' => 'db2fadm1',
#    'fenced_password' => 'passw0rd',
#    'fcm_port' => '60000',
#    'databases' => {
#      'db11' => {
#        'db_name' => 'db11',
#        'db_data_path' => '/home/db2inst1',
#        'db_path' => '/home/db2inst1',
#        'pagesize' => '4096',
#        'territory' => 'US',
#        'codeset' => 'UTF-8',
#        'db_collate' => 'SYSTEM'
#      }
#    }
#  }
#}

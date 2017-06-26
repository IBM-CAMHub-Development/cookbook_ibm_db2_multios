#
# Cookbook Name:: db2
# attributes :: default
#
# Copyright IBM Corp. 2017, 2017

# <> DB2 base package version
# <md>attribute 'db2/base_version',
# <md>          :displayname => 'DB2BaseVersion',
# <md>          :description => 'The version of DB2 to install.',
# <md>          :choice => [ '10.5.0.3', '10.5.0.8', '11.1.0.0' ],
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
# <md>          :displayname => 'DB2FixpackVersion',
# <md>          :description => 'The version of DB2 fixpack to install. If no fixpack is required, set this value the same as base_version.',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10.5.0.8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['fp_version'] = node['db2']['base_version']

# <> The product installation directory
# <md>attribute 'db2/install_dir',
# <md>          :displayname => 'InstallDir',
# <md>          :description => 'The directory to install DB2 Binaries, reccomended /opt/ibm/db2/V<db2_version>',
# <md>          :choice => [ '/opt/ibm/db2/V10.5',
# <md>                       '/opt/ibm/db2/V11.1' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/opt/ibm/db2/V10.5',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'role',
# <md>          :parm_type => 'component',
# <md>          :secret => 'false'
default['db2']['install_dir'] = '/opt/ibm/db2/V' + node['db2']['base_version'].split('.')[0, 2].join('.')

## das server
# <> DB2 Administration Server (DAS) username
# <md>attribute 'db2/das_username',
# <md>          :displayname => 'das_username',
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
# <md>          :displayname => 'das_password',
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

# <md>attribute 'db2/instances/instance($INDEX)/instance_prefix',
# <md>          :displayname => 'instance_prefix',
# <md>          :description => 'Instance prefix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'DB2_INST',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_type',
# <md>          :displayname => 'instance_type',
# <md>          :description => 'Instance type',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ESE',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_username',
# <md>          :displayname => 'instance_username',
# <md>          :description => 'instance_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_groupname',
# <md>          :displayname => 'instance_groupname',
# <md>          :description => 'instance_groupname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2iadm1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/instance_password',
# <md>          :displayname => 'instance_password',
# <md>          :description => 'instance_password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/instance_dir',
# <md>          :displayname => 'instance_dir',
# <md>          :description => 'instance_dir',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/port',
# <md>          :displayname => 'port',
# <md>          :description => 'port',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '50000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_username',
# <md>          :displayname => 'fenced_username',
# <md>          :description => 'fenced_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_groupname',
# <md>          :displayname => 'fenced_groupname',
# <md>          :description => 'fenced_groupname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/fenced_password',
# <md>          :displayname => 'fenced_password',
# <md>          :description => 'fenced_password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instances/instance($INDEX)/fcm_port',
# <md>          :displayname => 'fcm_port',
# <md>          :description => 'fcm_port',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '60000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <> DB2 Databse
# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_name',
# <md>          :displayname => 'db_name',
# <md>          :description => 'db_name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db01',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_data_path',
# <md>          :displayname => 'db_data_path',
# <md>          :description => 'db_data_path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_path',
# <md>          :displayname => 'db_path',
# <md>          :description => 'db_path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/instance_username',
# <md>          :displayname => 'instance_username',
# <md>          :description => 'instance_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/pagesize',
# <md>          :displayname => 'pagesize',
# <md>          :description => 'pagesize',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/territory',
# <md>          :displayname => 'territory',
# <md>          :description => 'territory',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'US',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/codeset',
# <md>          :displayname => 'codeset',
# <md>          :description => 'codeset',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'UTF-8',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instances/instance($INDEX)/databases/database($INDEX)/db_collate',
# <md>          :displayname => 'db_collate',
# <md>          :description => 'db_collate',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'SYSTEM',
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

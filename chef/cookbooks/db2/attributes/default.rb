#
# Cookbook Name:: db2
# attributes :: default
#
# Copyright IBM Corp. 2017, 2017

# <> DB2 version
# <md>attribute 'db2/version',
# <md>          :displayname => 'DB2Version',
# <md>          :description => 'The Version of DB2 to install.',
# <md>          :choice => [ '10.5', '11.1' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '10.5',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['version'] = '10.5'

# <> Version of the fixpack that is included in the base DB2 package
# <md>attribute 'db2/included_fixpack',
# <md>          :displayname => 'DB2IncludedFixpack',
# <md>          :description => 'The Fixpack of DB2 included in base package.',
# <md>          :choice => [ '0',
# <md>                       '3',
# <md>                       '8' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '8',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['included_fixpack'] = '8'

# <> DB2 fixpack
# <md>attribute 'db2/fixpack',
# <md>          :displayname => 'DB2Fixpack',
# <md>          :description => 'The Fixpack of DB2 to install.',
# <md>          :choice => [ '0',
# <md>                       '7',
# <md>                       '8' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['fixpack'] = '0'

# <> DB2 modification level
# <md>attribute 'db2/modpack',
# <md>          :displayname => 'DB2ModPack',
# <md>          :description => 'DB2 modification level',
# <md>          :choice => [ '0',
# <md>                       '1' ],
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '0',
# <md>          :selectable => 'true',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['modpack'] = '0'

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
default['db2']['install_dir'] = '/opt/ibm/db2/V' + node['db2']['version']

## das server
# <> DB2 Administration Server (DAS) username
# <md>attribute 'db2/das_username',
# <md>          :displayname => 'das_username',
# <md>          :description => 'DB2 Administration Server (DAS) username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2das1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['das_username'] = 'db2das1'

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
# <md>attribute 'db2/instance/default/instance_prefix',
# <md>          :displayname => 'instance_prefix',
# <md>          :description => 'Instance prefix',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'DB2_INST',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/instance_type',
# <md>          :displayname => 'instance_type',
# <md>          :description => 'Instance type',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'ESE',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/instance_username',
# <md>          :displayname => 'instance_username',
# <md>          :description => 'instance_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/instance_groupname',
# <md>          :displayname => 'instance_groupname',
# <md>          :description => 'instance_groupname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2iadm1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/instance_password',
# <md>          :displayname => 'instance_password',
# <md>          :description => 'instance_password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instance/default/database_data_dir',
# <md>          :displayname => 'database_data_dir',
# <md>          :description => 'database_data_dir',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/port',
# <md>          :displayname => 'port',
# <md>          :description => 'port',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '50000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/fenced_username',
# <md>          :displayname => 'fenced_username',
# <md>          :description => 'fenced_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fenc1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/fenced_groupname',
# <md>          :displayname => 'fenced_groupname',
# <md>          :description => 'fenced_groupname',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2fadm',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/instance/default/fenced_password',
# <md>          :displayname => 'fenced_password',
# <md>          :description => 'fenced_password',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'true'

# <md>attribute 'db2/instance/default/fcm_port',
# <md>          :displayname => 'fcm_port',
# <md>          :description => 'fcm_port',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '60000',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['instance'] = {}
# Sample instance attribute. This will be set in role file
#default['db2']['instance'] =
#  { 'instance1' => { 'instance_prefix' => 'DB2_INST',
#                    'instance_type' => 'ESE',
#                    'instance_username' => 'db2inst1',
#                    'instance_groupname' => 'db2iadm1',
#                    'instance_password' => 'passw0rd',
#                    'database_data_dir' => '/home/db2inst1',
#                    'port' => '50000',
#                    'fenced_username' => 'db2fenc1',
#                    'fenced_groupname' => 'db2fadm1',
#                    'fenced_password' => 'passw0rd',
#                    'fcm_port' => '60000'} }

# <> DB2 Databse
# <md>attribute 'db2/database/db01/db_name',
# <md>          :displayname => 'db_name',
# <md>          :description => 'db_name',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db01',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/db_data_path',
# <md>          :displayname => 'db_data_path',
# <md>          :description => 'db_data_path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/db_path',
# <md>          :displayname => 'db_path',
# <md>          :description => 'db_path',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '/home/db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/instance_username',
# <md>          :displayname => 'instance_username',
# <md>          :description => 'instance_username',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'db2inst1',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/pagesize',
# <md>          :displayname => 'pagesize',
# <md>          :description => 'pagesize',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => '4096',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/territory',
# <md>          :displayname => 'territory',
# <md>          :description => 'territory',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'US',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'

# <md>attribute 'db2/database/db01/codeset',
# <md>          :displayname => 'codeset',
# <md>          :description => 'codeset',
# <md>          :type => 'string',
# <md>          :required => 'recommended',
# <md>          :default => 'UTF-8',
# <md>          :selectable => 'false',
# <md>          :precedence_level => 'node',
# <md>          :parm_type => 'node',
# <md>          :secret => 'false'
default['db2']['database'] = {}
# Sample database attribute. This will be set in role file
#default['db2']['database'] =
#  { 'db1' => { 'db_name' => 'database1',
#               'instance_username' => 'db2inst1',
#               'pagesize' => '4096',
#               'territory' => 'US',
#               'codeset" => 'UTF-8'} }

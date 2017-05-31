#
# Cookbook Name:: db2
# Recipe:: fixpack
#
# Copyright IBM Corp. 2017, 2017
#
# <> Fixpack recipe (fixpack.rb)
# <> This recipe performs product fixpack installation.


db2_fixpack "Install FP" do
  action :install
  not_if { node['db2']['fp_version'] == node['db2']['base_version'] }
end

#
# Cookbook Name:: chef-mre
# Recipe:: compliance
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chef-mre::_deps'

append_if_no_line "Add loopback => hostname" do
  path "/etc/hosts"
  line "127.0.0.1 #{node['chef-mre']['domain_prefix']}compliance.#{node['chef-mre']['domain']} compliance"
end

execute 'set hostname' do
  command "hostnamectl set-hostname #{node['chef-mre']['compliance']['hostname']}"
  action :run
  user 'root'
end

chef_ingredient 'compliance' do
  package_source "ftp://172.31.10.169/chef-compliance.rpm"
end

chef_ingredient 'compliance' do
  accept_license true
  action :reconfigure
end

delete_lines "Remove loopback entry we added earlier" do
  path "/etc/hosts"
  pattern "^127\.0\.0\.1.*localhost.*#{node['chef-mre']['domain_prefix']}compliance\.#{node['chef-mre']['domain']}.*compliance"
end
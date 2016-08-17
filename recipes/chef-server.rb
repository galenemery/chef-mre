#
# Cookbook Name:: chef-mre
# Recipe:: chef-server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Cookbook Name:: chef-server
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chef-mre::_deps'

append_if_no_line "Add loopback => hostname" do
  path "/etc/hosts"
  line "127.0.0.1 #{node['chef-mre']['domain_prefix']}chef-server.#{node['chef-mre']['domain']} chef-server"
end

execute 'set hostname' do
  command "hostnamectl set-hostname #{node['chef-mre']['chef-server']['hostname']}"
  action :run
  user 'root'
end

directory '/var/opt/opscode'
directory '/var/opt/opscode/nginx'
directory '/var/opt/opscode/nginx/ca'
directory '/etc/opscode' do
  mode '0644'
end

chef_ingredient 'chef-server' do
  package_source "ftp://172.31.10.169/chef-server-core.rpm"
end

chef_ingredient 'chef-server' do
  action :reconfigure
end

chef_ingredient 'push-jobs-server' do
  package_source "ftp://172.31.10.169/opscode-push-jobs-server.rpm"
end

chef_ingredient 'push-jobs-server' do
  action :reconfigure
end

chef_ingredient 'manage' do
  package_source "ftp://172.31.10.169/chef-manage.rpm"
end

chef_ingredient 'chef-server' do
  action :reconfigure
end

chef_ingredient 'manage' do
  accept_license true
  action :reconfigure
end

delete_lines "Remove loopback entry we added earlier" do
  path "/etc/hosts"
  pattern "^127\.0\.0\.1.*localhost.*#{node['chef-mre']['domain_prefix']}chef-server\.#{node['chef-mre']['domain']}.*chef-server"
end


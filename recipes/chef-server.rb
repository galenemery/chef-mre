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


##TODO: Grab and extract zip archive with chef-server packages

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

# What the fuck is going here?
# append_if_no_line "Add certificate to authorized_keys" do
#   path "/home/#{node['chef-mre']['admin-user']}/.ssh/authorized_keys"
#   line lazy { IO.read('/tmp/public.pub') }
# end

directory '/var/opt/opscode'
directory '/var/opt/opscode/nginx'
directory '/var/opt/opscode/nginx/ca'
directory '/etc/opscode' do
  mode '0644'
end

# %w(crt key).each do |ext|
#   file "/var/opt/opscode/nginx/ca/#{node['chef-mre']['domain_prefix']}chef-server.#{node['chef-mre']['domain']}.#{ext}" do
#     content lazy { IO.read("/tmp/chef-server.#{ext}") }
#     action :create
#   end
# end


#TODO: Modify all chef_ingredient blocks to utilize local packages
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

##TODO: Use own hosts file recipe instead
#include_recipe 'wombat::etc-hosts'


delete_lines "Remove loopback entry we added earlier" do
  path "/etc/hosts"
  pattern "^127\.0\.0\.1.*localhost.*#{node['chef-mre']['domain_prefix']}chef-server\.#{node['chef-mre']['domain']}.*chef-server"
end
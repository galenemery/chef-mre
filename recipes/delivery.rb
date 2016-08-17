#
# Cookbook Name:: chef-mre
# Recipe:: delivery
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'chef-mre::_deps'

append_if_no_line "Add loopback => hostname" do
  path "/etc/hosts"
  line "127.0.0.1 #{node['chef-mre']['domain_prefix']}delivery.#{node['chef-mre']['domain']} delivery"
end

execute 'set hostname' do
  command "hostnamectl set-hostname #{node['chef-mre']['delivery']['hostname']}"
  action :run
  user 'root'
end

chef_ingredient 'delivery' do
  package_source "ftp://172.31.10.169/delivery.rpm"
end

chef_ingredient 'delivery' do
  action :reconfigure
end

delete_lines "Remove loopback entry we added earlier" do
  path "/etc/hosts"
  pattern "^127\.0\.0\.1.*localhost.*#{node['chef-mre']['domain_prefix']}delivery\.#{node['chef-mre']['domain']}.*delivery"
end
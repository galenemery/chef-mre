#
# Cookbook Name:: chef-mre
# Recipe:: _deps
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'extract gems' do
  command "tar -xvf /var/chef/cache/cookbooks/chef-mre/files/default/gems.tar -C /opt/chef/embedded/lib/ruby/gems/2.1.0"
  not_if do
    ::File.exist?('/var/www/favicon.ico')
  end
end
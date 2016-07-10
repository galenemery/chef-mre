#
# Cookbook Name:: chef-mre
# Recipe:: _deps
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

extract_path = Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')

execute 'extract gems' do
  command "tar -xvf /var/chef/cache/cookbooks/chef-mre/files/default/gems.tar -C /opt/chef/embedded/lib/ruby/gems/2.1.0"
  not_if do
    ::File.exist?('/var/www/favicon.ico')
  end
end


# gem_package 'mixlib-install' do
#   gem_binary Chef::Util::PathHelper.join(Chef::Config.embedded_dir,'bin','gem')
#   source '/var/chef/cache/cookbooks/chef-mre/files/default/vendor/gems'
#   options "--no-user-install"
#   action :upgrade
# end
#
# Cookbook Name:: chef-mre
# Recipe:: provision-chef-server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
require 'chef/provisioning/ssh_driver'

with_driver 'ssh'

with_machine_options({
  convergence_options: {
      install_sh_url: "ftp://172.31.10.169/install.sh"
    },
    transport_options: {
    ip_address: node['chef-mre']['chef-server']['ip'],
    username: node['chef-mre']['admin-user'],
      ssh_options: {
          :keys => node['chef-mre']['ssh-key']
      }
  }
})


machine node['chef-mre']['chef-server']['hostname'] do
    recipe 'chef-mre::chef-server'
end

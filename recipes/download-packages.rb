#
# Cookbook Name:: chef-mre
# Recipe:: download-chef-server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

chef_gem 'mixlib-install' do
  compile_time true
end

require 'mixlib/install'

node["chef-mre"]["products"].each do |product_name|
  version = node["chef-mre"]["#{product_name}_version"]
  options = {
    channel: :current,
    product_name: product_name,
    product_version: version,
    platform: "#{node["chef-mre"]["server_platform"]["name"]}",
    platform_version: "#{node["chef-mre"]["server_platform"]["version"]}",
    architecture: "#{node["chef-mre"]["server_platform"]["architecture"]}"
  }

  artifact = Mixlib::Install.new(options).artifact_info

directory "#{Chef::Config[:file_cache_path]}/packages"

  remote_file "#{Chef::Config[:file_cache_path]}/packages/#{product_name}-#{version}.rpm" do 
    source lazy{ artifact.url }
  end
end
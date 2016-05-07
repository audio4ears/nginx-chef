#
# Cookbook Name:: nginx-chef
# Recipe:: default_site
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

link 'link_welcome_site' do
  target_file "#{node['nginx']['conf_dir']}/sites-enabled/welcome.conf"
  to "#{node['nginx']['conf_dir']}/sites-available/welcome.conf"
  action :nothing
end

template 'default_site' do
  source 'welcome.conf.erb'
  path "#{node['nginx']['conf_dir']}/sites-available/welcome.conf"
  owner 'root'
  group 'root'
  mode '0644'
  action :create_if_missing
  notifies :create, 'link[link_welcome_site]', :immediately
end

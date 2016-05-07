#
# Cookbook Name:: nginx-chef
# Recipe:: nginx_service
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'nginx_service' do
  source 'nginx.service.erb'
  path '/lib/systemd/system/nginx.service'
  owner 'root'
  group 'root'
  action :create
end

service 'nginx' do
  action [ :enable, :start ]
end

#
# Cookbook Name:: nginx-chef
# Recipe:: nginx_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# include recipe(s)
include_recipe 'build-essential'

# include package(s)
package [ 'pcre-devel', 'openssl-devel', 'zlib-devel' ]

user 'nginx' do
  system true
  home '/var/www'
  shell '/bin/false'
end

directory 'nginx_log_dir' do
  path '/var/log/nginx'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

bash 'install_nginx' do
  cwd "/usr/local/src/nginx-#{node['nginx']['version']}"
  code <<-EOF
    ./configure \
      --prefix=#{node['nginx']['prefix']} \
      --sbin-path=#{node['nginx']['sbin_path']} \
      --conf-path=#{node['nginx']['conf_path']} \
      --pid-path=#{node['nginx']['pid_path']} \
      --error-log-path=#{node['nginx']['error_log_path']} \
      --http-log-path=#{node['nginx']['access_log_path']} \
      --user=#{node['nginx']['user']} \
      --group=#{node['nginx']['group']} \
      #{node['nginx']['modules'].join(' ')}
    make
    make install
    EOF
  user 'root'
  group 'root'
  action :nothing
end

bash 'extract_nginx' do
  cwd '/usr/local/src'
  code "tar xzvf nginx-#{node['nginx']['version']}.tar.gz"
  action :nothing
end

remote_file 'download_nginx' do
  source node['nginx']['source_url']
  path "/usr/local/src/nginx-#{node['nginx']['version']}.tar.gz"
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
  notifies :run, 'bash[extract_nginx]', :immediately 
  notifies :run, 'bash[install_nginx]', :immediately 
end

link 'link_nginx' do
  target_file '/usr/bin/nginx'
  to node['nginx']['sbin_path']
  action :create
end

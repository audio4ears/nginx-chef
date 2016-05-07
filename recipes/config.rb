#
# Cookbook Name:: nginx-chef
# Recipe:: nginx_config
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


Dir["#{node['nginx']['conf_dir']}/*.default"].each do |path|
  #file ::File.expand_path(path) do
  file path do
    backup false
    action :delete
  end
end

directory 'sites_available_directory' do
  path "#{node['nginx']['conf_dir']}/sites-available"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory 'sites_enabled_directory' do
  path "#{node['nginx']['conf_dir']}/sites-enabled"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

if !node['nginx']['conf']['resolvers']
  ruby_block 'get_resolvers' do
    block do
      resolvers = Array.new
      File.open('/etc/resolv.conf','r').each_line do |line|
        entry = line[/(?:[0-9]{1,3}\.){3}[0-9]{1,3}/]
        if !entry.nil?
          resolvers.push(entry)
        end
      end
      node.default['nginx']['conf']['resolvers'] = resolvers.uniq
    end
  end
end

template 'nginx_config' do
  source 'nginx.conf.erb'
  path "#{node['nginx']['conf_dir']}/nginx.conf"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  variables lazy { {
    config: node['nginx']['conf'],
    resolvers: node['nginx']['conf']['resolvers'].join(' ')
  } }
end

if node['nginx']['modules'].include?('--with-http_ssl_module')
  execute 'create_dhparam' do
    command 'openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048'
    user 'root'
    action :nothing
  end

  file 'dhparam.pem' do
    path '/etc/ssl/certs/dhparam.pem'
    owner 'root'
    group 'root'
    mode '0644'
    action :create_if_missing
    notifies :run, 'execute[create_dhparam]', :immediately
  end
end

if node['nginx']['modules'].include?('--with-http_realip_module')
  template 'configure_http_realip_module' do
    source 'properties.erb'
    path "#{node['nginx']['conf_dir']}/http_realip.conf"
    owner 'root'
    group 'root'
    mode '0644'
    variables config: node['nginx']['http_realip_module']
  end
end

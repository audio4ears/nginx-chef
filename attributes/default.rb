# nginx install
default['nginx']['version'] = '1.10.0'
default['nginx']['source_url'] = 'http://nginx.org/download/nginx-1.10.0.tar.gz'
default['nginx']['conf_dir'] = '/etc/nginx'
default['nginx']['prefix'] = '/etc/nginx'
default['nginx']['sbin_path'] = '/opt/nginx-1.10.0/sbin/nginx'
default['nginx']['conf_path'] = '/etc/nginx/nginx.conf'
default['nginx']['pid_path'] = '/var/run/nginx.pid'
default['nginx']['error_log_path'] = '/var/log/nginx/error.log'
default['nginx']['access_log_path'] = '/var/log/nginx/access.log'
default['nginx']['user'] = 'nginx'
default['nginx']['group'] = 'nginx'
default['nginx']['modules'] = [
  '--with-http_gzip_static_module',
  '--with-http_realip_module',
  '--with-http_ssl_module'
  ]

# nginx conf
default['nginx']['conf'] = {
  'worker_processes' => node['cpu']['total'],
  'client_max_body_size' => 25,
  'server_names_hash_bucket_size' => 128,
  'limit_conn_slimits' => 20,
  'https_only' => false
}

# module: http_realip_module
default['nginx']['http_realip_module'] = {
  'set_real_ip_from' => '127.0.0.1',
  'real_ip_header' => 'X-Forwarded-For',
  'real_ip_recursive' => 'on'
}

require 'spec_helper'

describe 'nginx-chef::install' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # packages
  describe package('openssl-devel') do
    it { should be_installed }
  end
  describe package('pcre-devel') do
    it { should be_installed }
  end
  describe package('zlib-devel') do
    it { should be_installed }
  end

  # files & directories
  describe file('/etc/nginx') do
    it { should be_directory }
  end
  describe file('/etc/nginx/nginx.conf') do
    it { should be_file }
  end
  describe file('/var/run/nginx.pid') do
    it { should be_file }
  end
  describe file('/var/log/nginx') do
    it { should be_directory }
  end

  # users & groups
  describe user('nginx') do
    it { should exist }
  end
  describe group('nginx') do
    it { should exist }
  end

  # links
  describe file('/usr/bin/nginx') do
    it { should be_symlink }
  end
end

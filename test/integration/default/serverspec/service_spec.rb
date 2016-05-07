require 'spec_helper'

describe 'nginx-chef::service' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # files & directories
  describe file('/lib/systemd/system/nginx.service') do
    it { should be_file }
  end

  # service
  describe service('nginx') do
    it { should be_enabled }
  end
  describe service('nginx') do
    it { should be_running }
  end
end

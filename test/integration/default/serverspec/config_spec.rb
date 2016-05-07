require 'spec_helper'

describe 'nginx-chef::config' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  # files and directories
  describe file('/etc/nginx/sites-available') do
    it { should be_directory }
  end
  describe file('/etc/nginx/sites-enabled') do
    it { should be_directory }
  end
end

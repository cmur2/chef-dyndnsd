require 'spec_helper'

describe 'dyndnsd::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'debian', :version => '8.7') do |node|
      node.normal['dyndnsd'] = {
        'logfile' => '/var/log/dyndnsd.log',
        'domain' => 'example.org',
        'updater' => {
          'name' => 'command_with_bind_zone',
          'params' => {
            'zone_file' => 'dyn.zone',
            'command' => 'echo',
            'ttl' => '5m',
            'dns' => 'dns.example.org.',
            'email_addr' => 'admin.example.org.'
          }
        },
        'users' => {
          'foo' => {
            'password' => 'secret',
            'hosts' => [
              'foo.example.org'
            ]
          }
        }
      }
    end.converge('dyndnsd::default')
  end

  it 'installs dyndnsd gem' do
    expect(chef_run).to install_gem_package('dyndnsd')
  end

  it 'configures dyndnsd' do
    expect(chef_run).to create_file("/opt/dyndnsd/config.yaml")
  end

  it 'creates an init.d script' do
    expect(chef_run).to create_template("/etc/init.d/dyndnsd")
  end

  it 'enables and starts dyndnsd' do
    expect(chef_run).to start_service("dyndnsd")
    expect(chef_run).to enable_service("dyndnsd")
  end
end

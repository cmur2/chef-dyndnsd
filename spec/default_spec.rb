require 'chefspec'

describe 'dyndnsd::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.node.set['dyndnsd'] = {
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
    chef_runner.node.automatic_attrs['platform_family'] = 'debian'
    chef_runner.converge 'dyndnsd::default'
  end

  it 'installs dyndnsd gem' do
    expect(chef_run).to install_gem_package 'dyndnsd'
  end
  
  it 'configures dyndnsd' do
    expect(chef_run).to create_file_with_content "/opt/dyndnsd/config.yaml", ""
  end
  
  it 'creates an init.d script' do
    expect(chef_run).to create_file_with_content "/etc/init.d/dyndnsd", ""
  end
  
  it 'enables and starts dyndnsd' do
    expect(chef_run).to start_service "dyndnsd"
    expect(chef_run).to set_service_to_start_on_boot "dyndnsd"
  end
end

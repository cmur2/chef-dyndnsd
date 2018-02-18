require 'spec_helper'

describe 'dyndnsd::logrotate' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(:platform => 'debian', :version => '8.7', :step_into => ['logrotate_app']) do |node|
      node.normal['dyndnsd'] = {
        'logfile' => '/var/log/dyndnsd.log'
      }
    end.converge('logrotate', 'dyndnsd::logrotate')
  end

  it 'creates dyndnsd logrotate config' do
    expect(chef_run).to create_template("/etc/logrotate.d/dyndnsd")
  end
end

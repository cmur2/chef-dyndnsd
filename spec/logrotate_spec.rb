require 'chefspec'

describe 'dyndnsd::logrotate' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path, :step_into => ['logrotate_app'])
  end

  let(:chef_run) do
    chef_runner.converge 'logrotate', 'dyndnsd::logrotate'
  end

  it 'creates dyndnsd logrotate config' do
    expect(chef_run).to create_file_with_content "/etc/logrotate.d/dyndnsd", ""
  end
end

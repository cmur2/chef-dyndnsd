require 'chefspec'

describe 'dyndnsd::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'dyndnsd::default'
  end

  it 'installs dyndnsd gem' do
    expect(chef_run).to install_gem_package 'dyndnsd'
  end
  
  it 'configures dyndnsd' do
    expect(chef_run).to create_file_with_content "/opt/dyndnsd/config.yaml", ""
  end
  
  it 'enables and starts dyndnsd' do
    expect(chef_run).to start_service "dyndnsd"
    expect(chef_run).to set_service_to_start_on_boot "dyndnsd"
  end
end

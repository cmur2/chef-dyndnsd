
require 'yaml'

gem_package "dyndnsd"

cookbook_file "/etc/init.d/dyndnsd" do
  source "dyndnsd.init"
  owner "root"
  group "root"
  mode 00755
end

directory "/opt/dyndnsd" do
  owner "root"
  group "root"
  mode 00755
  recursive true
end

file "/opt/dyndnsd/config.yaml" do
  content YAML.dump(node['dyndnsd'])
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[dyndnsd]"
end

service "dyndnsd" do
  action [:enable, :start]
end

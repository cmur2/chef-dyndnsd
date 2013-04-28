
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

def to_ruby(source)
  case source
  when Hash
    out = {}
    source.each { |k,v| out[k] = to_ruby(v) }
    out
  when Array
    source.map { |e| to_ruby(e) }
  else
    source
  end
end

dyndnsd_config = YAML.dump(to_ruby(node['dyndnsd']))

file "/opt/dyndnsd/config.yaml" do
  content dyndnsd_config
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[dyndnsd]"
end

service "dyndnsd" do
  action [:enable, :start]
end


require 'yaml'

include_recipe "build-essential"

gem_package "json"

gem_package "dyndnsd" do
  version node['dyndnsd_version'] if node.has_key?('dyndnsd_version')
end

execute "systemctl-daemon-reload" do
  command "systemctl daemon-reload || true"
  action :nothing
end

template "/etc/init.d/dyndnsd" do
  source "dyndnsd.init.erb"
  owner "root"
  group "root"
  mode 00755
  variables ({
    :daemon => node['dyndnsd_daemon_binary']
  })
  notifies :run, "execute[systemctl-daemon-reload]", :immediately
  notifies :restart, "service[dyndnsd]"
end

directory "/opt/dyndnsd" do
  owner "root"
  group "root"
  mode 00755
  recursive true
end

def to_ruby(source)
  case source
  when Hash,Mash,Chef::Node::Attribute
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

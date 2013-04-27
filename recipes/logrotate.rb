
begin
  include_recipe "logrotate"

  log = "/var/log/dyndnsd.log"
  #log = node['nsd3']['server']['logfile'] if not node['nsd3']['server']['logfile'] == ''
  
  user = "root"
  #user = node['nsd3']['server']['username'] if not node['nsd3']['server']['username'] == ''

  logrotate_app "dyndnsd" do
    cookbook "logrotate"
    path [log]
    options ["missingok", "compress", "copytruncate"]
    frequency "weekly"
    create "644 #{user} #{user}"
    rotate 4
  end
rescue
  Chef::Log.error "dyndnsd::logrotate requires the logrotate cookbook!"
end

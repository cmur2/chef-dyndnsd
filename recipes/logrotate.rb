
begin
  include_recipe "logrotate"

  log = nil
  log = node['dyndnsd']['logfile'] if node['dyndnsd']['logfile']
  
  user = "root"
  
  if log
    logrotate_app "dyndnsd" do
      cookbook "logrotate"
      path [log]
      options ["missingok", "compress", "copytruncate"]
      frequency "weekly"
      create "644 #{user} #{user}"
      rotate 4
    end
  end
rescue
  Chef::Log.error "dyndnsd::logrotate requires the logrotate cookbook!"
end

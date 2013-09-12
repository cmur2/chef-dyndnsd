
default['dyndnsd_daemon_binary'] = '/var/lib/gems/1.8/bin/dyndnsd'

default['dyndnsd'] = {
  'host' => '0.0.0.0',
  'port' => '80',
  #'logfile' => '/var/log/dyndnsd.log',
  'db' => '/opt/dyndnsd/db.json',
  #'domain' => 'example.org',
  #'updater' => {},
  #'users' => {}
}

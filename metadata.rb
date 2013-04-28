name             "dyndnsd"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache 2.0"
description      "Installs dyndnsd.rb as gem and configures it."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"

suggests "logrotate" # for dyndnsd::logrotate

supports "debian"

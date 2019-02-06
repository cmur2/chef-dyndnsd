name             "dyndnsd"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache-2.0"
description      "Installs dyndnsd.rb as gem and configures it."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.3.0"

depends "seven_zip", "< 3.0.0" # pin manually before build-essential to retain Chef 12 support
depends "windows", "< 5.2.3" # pin manually before build-essential to retain Chef 12 support
depends "build-essential"

suggests "logrotate" # for dyndnsd::logrotate

supports "debian"

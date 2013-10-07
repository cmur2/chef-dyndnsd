# chef-dyndnsd

[![Build Status](https://travis-ci.org/cmur2/chef-dyndnsd.png)](https://travis-ci.org/cmur2/chef-dyndnsd)

## Description

Installs [dyndnsd.rb](https://github.com/cmur2/dyndnsd) as gem and configures it from `node['dyndnsd']`.

## Usage

Use `recipe[dyndnsd::default]` to get dyndnsd.rb installed including an init script for Debian 6 and configuration in /opt/dyndnsd. Use `recipe[dyndnsd::logrotate]` to get logrotate configuration for dyndnsd.rb's logfile.

## Requirements

### Platform

It should work on all *nix systems providing Ruby 1.8 or higher.

## Recipes

### default

Takes all attributes beneath `node['dyndnsd']` and pastes the verbatim into the config.yaml of dyndnsd.rb.

### logrotate

Adds a dyndnsd.rb specific logrotate configuration when logrotate cookbook is found. No attributes needed.

## License

chef-dyndnsd is licensed under the Apache License, Version 2.0. See LICENSE for more information.

# == Class: puppetmaster_role
#
# Installing puppetmaster module

class puppetmaster_role {

  class { 'puppetdb': } ->
  exec { 'puppetdb-setup-ssl':
    command => '/opt/puppetlabs/bin/puppetdb ssl-setup',
    notify  => Service['puppetdb'],
    unless  => '/usr/bin/test -d /etc/puppetlabs/puppetdb/ssl',
    require => Package['puppetdb']
  }

  define postgresql::globals {
    $default_version = '9.5'
  }
}

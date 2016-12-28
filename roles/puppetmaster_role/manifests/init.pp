# == Class: puppetmaster_role
#
# Installing puppetmaster module

class puppetmaster_role {

  include puppetdb

  define postgresql::globals {
    $default_version = '9.5'
  }
}

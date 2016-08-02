# == Class puppetmaster::packages
# Setup all needed packages for puppetmaster
#

class puppetmaster::packages() {

  package { 'puppetserver':
    ensure => '2.4.0-1puppetlabs1',
  }

}

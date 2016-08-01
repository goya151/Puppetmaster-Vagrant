# == Class puppetmaster::packages
# Setup all needed packages for puppetmaster
#

class puppetmaster::packages() {

  package { 'puppetserver':
    ensure => '2.0.0-1puppetlabs1',
  }

}

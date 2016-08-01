#
#  Installing PuppetDB
#

class puppetdb::packages {

  package { 'puppetdb':
    ensure => 'installed',
  }
}
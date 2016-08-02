#
# Service PuppetDB
#

class puppetdb::service {

  service { 'puppetdb':
    ensure  => 'running',
    enable  => 'true',
    require => Package['puppetdb'];
  }
}
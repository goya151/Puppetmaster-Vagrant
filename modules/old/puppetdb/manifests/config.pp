#
#  Setup service PuppetDB
#

class puppetdb::config {

  exec { set_ssl_for_puppetdb:
    notify  => Service['puppetdb'],
    command => '/usr/lib/puppetdb/puppetdb-ssl-setup -f',
    unless  => '/bin/netstat -nlt | grep 8081 | grep -c LISTEN',
    require => Service['puppetserver'];
  }
  file { ['/etc/puppetdb/ssl/ca.pem', '/etc/puppetdb/ssl/private.pem', '/etc/puppetdb/ssl/public.pem']:
    replace => "no",
    ensure  => 'present',
    owner   => "puppetdb",
    group   => "puppetdb",
    mode    => '600',
    require => Exec['set_ssl_for_puppetdb'];
  }
  file { ['/etc/puppetdb', '/var/lib/puppetdb']:
    ensure  => directory,
    recurse => true,
    owner   => "puppetdb",
    group   => "puppetdb";
  }
  file { '/etc/puppetdb/conf.d/database.ini':
    content => template('puppetdb/database.ini'),
    notify  => Service['puppetdb'];
  }
}
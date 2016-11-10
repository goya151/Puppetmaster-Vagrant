# == Class: default_role
#
# This is the default_role for all nodes.
# It's installing the basic stuff, which we need on all nodes.
# Also taking care of the basic monitoring.

class default_role () {

  class { '::puppet':
    runmode      => 'cron',
    puppetmaster => 'puppetmaster.dev',
  }

  include set_locales
  include accounts
  include apt

  class { '::ntp':
    servers => [ 'pool.ntp.org' ],
  }

  package { [ 'vim', 'git', 'htop', 'python-yaml', 'mc']:
    ensure => installed,
  }

  exec { 'Add_hosts':
    command => 'sudo echo "192.168.12.12 puppetmaster.dev" >> /etc/hosts',
    path    => '/usr/bin/:/bin/',
    unless  => 'grep -c puppetmaster /etc/hosts',
  }

}

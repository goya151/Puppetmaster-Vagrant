# == Class: default_role
#
# This is the styla default_role for all nodes.
# It's installing the basic stuff, which we need on all nodes.
# Also taking care of the basic monitoring.

class default_role () {

  include set_locales
  include accounts
  include puppetagent
  include apt

  class { '::ntp':
    servers => [ '0.amazon.pool.ntp.org', '1.amazon.pool.ntp.org', '2.amazon.pool.ntp.org' ],
  }

  package { ['iptables-persistent','git','htop', 'python-yaml', 'libnagios-plugin-perl', 'mc']:
    ensure => installed,
  }
}

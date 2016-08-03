# == Class: default_role
#
# This is the styla default_role for all nodes.
# It's installing the basic stuff, which we need on all nodes.
# Also taking care of the basic monitoring.

class default_role () {

  include set_locales
  include accounts
#  include puppetagent
  include apt

  class { '::ntp':
    servers => [ 'pool.ntp.org' ],
  }

  package { [ 'git','htop', 'python-yaml', 'mc']:
    ensure => installed,
  }
}

# == Class puppetagent
# Setup puppet agent and configure it.

class puppetagent (
  $puppetserver        = $puppetagent::params::puppetserver,
  $working_environment = $puppetagent::params::working_environment,
  $puppetdbserver      = $puppetagent::params::puppetdbserver,
  $puppetdbport        = $puppetagent::params::puppetdbport
) inherits puppetagent::params {

  include puppetagent::packages
  include puppetagent::config

  service { 'puppet':
    ensure => 'running'
  }
}
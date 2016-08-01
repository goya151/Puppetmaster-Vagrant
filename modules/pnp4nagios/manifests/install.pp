class pnp4nagios::install inherits pnp4nagios {

  package {'pnp4nagios':
    ensure => latest;
  }
}
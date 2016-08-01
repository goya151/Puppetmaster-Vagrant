class pnp4nagios (
  $nagios_base = $pnp4nagios::params::nagios_base,
  $action_url  = $pnp4nagios::params::action_url,

) inherits pnp4nagios::params {

  include pnp4nagios::install
  include pnp4nagios::config

}
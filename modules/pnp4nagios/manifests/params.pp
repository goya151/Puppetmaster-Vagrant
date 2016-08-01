class pnp4nagios::params {

  $nagios_base = '/icinga/cgi-bin'
  $log_type    = 'file'
  $log_file    = '/var/log/pnp4nagios/npcd.log'
  $log_level   = '2'
  $action_url  = '/nagios/pnp/index.php?host=$HOSTNAME$'
}
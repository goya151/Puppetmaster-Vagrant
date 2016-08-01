# == Defined type: icinga2::object::create_nrpe_icinga_service_check
#
# This setups a general nrpe check for styla typical stuff. 
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::create_nrpe_icinga_service_check (
  $nrpe_command,
  $nrpe_args,
) {

  $service_name = "${::fqdn}-${name}"
  $nrpe_command_name = "check-${name}"
  @@icinga2::object::service { $service_name:
    display_name         => $name,
    check_command        => 'nrpe',
      vars               => {
        nrpe_command     => $nrpe_command_name,
      },
    target_dir           => '/etc/icinga2/objects/services',
    host_name            => $::fqdn,
    action_url           => "/pnp4nagios/graph?host=\$HOSTNAME\$&src=${service_name}&srv=${service_name}",
    enable_notifications => true,
  }
  icinga2::nrpe::command { $nrpe_command_name:
    nrpe_plugin_name   => $nrpe_command,
    nrpe_plugin_args   => $nrpe_args,
  }

}
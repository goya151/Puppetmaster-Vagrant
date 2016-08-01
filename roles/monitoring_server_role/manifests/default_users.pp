#  Creating maillist users for icinga
#
#
class monitoring_server_role::default_users (
  $mail_domain = $::monitoring_server_role::mail_domain,
){

  icinga2::object::user { 'alert':
    enable_notifications => true,
    types                => ['Problem, Acknowledgement, Recovery, Custom, FlappingStart, FlappingEnd, DowntimeStart, DowntimeEnd, DowntimeRemoved'],
    states               => ['OK, Warning, Critical, Unknown'],
    groups               => ['icingaadmins'],
    email                => "alert@${mail_domain}",
  }

  icinga2::object::user { 'alert-critical':
    enable_notifications => true,
    types                => ['Problem'],
    states               => ['OK, Critical'],
    groups               => ['icingaadmins'],
    email                => "alert-critical@${mail_domain}",
  }
}
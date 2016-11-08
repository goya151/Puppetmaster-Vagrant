class monitoring_server_role::params {
  $icinga_users              = hiera('users')
  $groups                    = ['icingaadmins']
  $types                     = ['Problem, Acknowledgement, Recovery, Custom, FlappingStart, FlappingEnd, DowntimeStart, DowntimeEnd, DowntimeRemoved']
  $states                    = ['OK, Warning, Critical, Unknown']
  $enable_notifications      = 'false'
  $mail_domain               = 'dev.com'
  $site_checks               = hiera('site_checks')
  $site_checks_notifications = hiera('site_checks_notifications')
}

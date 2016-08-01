#
# Parameters for newrelic
#
class newrelic::params {
  $path_newrelic     = '/usr/local/jboss'
  $start_install_cmd = "/usr/bin/java -jar ${path_newrelic}/newrelic/newrelic.jar install"
  $jboss_app_name    = "${fqdn}"
  $license_key       = '542b7527b76c1f728fe73ed790c0d9a958728f02'
}
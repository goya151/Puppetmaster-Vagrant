#
# Installation of newrelic agent for jboss
#
class newrelic::agent (
  $path_newrelic     = $newrelic::params::path_newrelic,
  $jboss_app_name    = $newrelic::params::jboss_app_name,
  $license_key       = $newrelic::params::license_key,
  $start_install_cmd = $newrelic::params::start_install_cmd
) inherits newrelic::params {

  include newrelic::install
  include newrelic::config

}
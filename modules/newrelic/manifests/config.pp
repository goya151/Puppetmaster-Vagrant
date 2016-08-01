#
# Config for newrelic.
#
class newrelic::config inherits newrelic::agent {

  file { "${path_newrelic}/newrelic/newrelic.yml":
    ensure  => file,
    content => template('newrelic/newrelic.yml'),
    require => Package['jboss-styla'];
  }
}

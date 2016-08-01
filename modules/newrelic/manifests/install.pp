#
# Installing newrelic agent into jboss folder
#
class newrelic::install inherits newrelic::agent {

  package {'newrelic-styla':
    ensure  => latest,
    require => Exec['apt_update'];
  }
}
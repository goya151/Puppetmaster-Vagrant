# == Class: java_role
#
# Installing java 8

class java_role {

  include java

  package { "oracle-java8-installer":
    ensure  => installed,
    require => Exec['apt-update-oracle'];
  }
}
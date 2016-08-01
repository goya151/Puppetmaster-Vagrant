# == Class: jenkins_server_role
#
#  Setup Jenkins, install pligins, importing users, creating jobs from xml-files.

class jenkins_server_role () {

  class { 'jenkins':
    config_hash => {
        'HTTP_PORT' => { 'value' => '8081' },
    },
    cli => true }

  jenkins::plugin { ['git', 'token-macro', 'github', 'github-api', 'email-ext', 'startup-trigger-plugin']: }

  jenkins::job { 'backend' :
    config => template('jenkins_server_role/backend.xml.erb'),
  }
  jenkins::job { 'frontend' :
    config => template('jenkins_server_role/frontend.xml.erb'),
  }

  # Get data from hiera/common.yaml and create users for Jenkins
  $jenkins_users = hiera ('users')

  $jenkins_users.each |$username, $user| {
    jenkins::user { "${username}":
      email      => $user[email],
      password   => $user[htpasswdmd5hash],
      full_name  => $user[realname],
      public_key => $user[sshkey],
    }
  }

  #Switch on security
  # As Jenkins has a bug https://issues.jenkins-ci.org/browse/JENKINS-22346
  # with secirity is on, we will has an error.
#  class { jenkins::security: security_model => 'full_control' }

}

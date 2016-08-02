# == Class puppetmaster::config
# Manage all config files for puppetmaster
#

class puppetmaster::config() {

  file { '/etc/puppetlabs/code/hiera.yaml':
    ensure   => file,
    source   => 'puppet:///modules/puppetmaster/hiera.yaml',
  }

  $synch_puppet_script = '/usr/local/bin/synch-puppet.sh'
  file { $synch_puppet_script :
    ensure  => file,
    mode    => '0744',
    content => template('puppetmaster/synch-puppet.sh.erb'),
  }

  cron { 'synch_puppet':
    command => "/${synch_puppet_script} 2>&1|logger",
    user    => root,
    hour    => '*',
    minute  => '*',
  }

  file { '/root/.ssh/id_rsa':
    ensure  => file,
    source  => 'puppet:///modules/puppetmaster/id_rsa',
    mode    => '0600'
  }

  exec { 'Clean_ssl_folder':
    command => '/bin/rm -rf /etc/puppetlabs/puppet/ssl',
  }

  service { 'puppetserver':
    enable      => true,
    ensure      => running,
    require     => File["${settings::confdir}/puppet.conf"];
  }

  file { '/etc/puppetlabs/puppet/routes.yaml':
    ensure   => file,
    source   => 'puppet:///modules/puppetmaster/routes.yaml',
    notify   => Service['puppetserver']
  }
}

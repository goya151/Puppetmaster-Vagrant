# == Class: repository_server_role
#
#   Configures repository server with apache2 and all sign keys
#

class repository_server_role() {

  $basedir = '/var/lib/apt/repo'

  ensure_packages('apache2')

  file { '/etc/apache2/sites-enabled/25-apt.magalog.net.conf':
    ensure => present,
    source => 'puppet:///modules/repository_server_role/25-apt.magalog.net.conf',
  }

  file { '/etc/apache2/.htpasswd':
    ensure => present,
    source => 'puppet:///modules/repository_server_role/.htpasswd',
  }

  class { 'reprepro':
    basedir => $basedir,
  }

  reprepro::repository { 'dev':
    basedir => $basedir,
    options => ['basedir .'],
  }

  # Create a distribution within that repository
  reprepro::distribution { 'trusty':
    basedir       => $basedir,
    repository    => 'dev',
    origin        => 'dev',
    label         => 'dev',
    suite         => 'trusty',
    architectures => 'amd64 i386',
    components    => 'main contrib non-free',
    description   => 'Package repository',
    sign_with     => 'admin@dev.com',
    not_automatic => 'No',
  }

  # Ensure your public key is accessible to download
  file { '/var/lib/apt/repo/dev/dev.gpg':
    ensure => present,
    owner  => 'www-data',
    group  => 'reprepro',
    mode   => '0644',
    source => 'puppet:///modules/repository_server_role/.gnupg/dev.gpg',
  }

  file { '/root/.gnupg':
    ensure  => directory,
    source  => 'puppet:///modules/repository_server_role/.gnupg',
    recurse => true,
  }

}
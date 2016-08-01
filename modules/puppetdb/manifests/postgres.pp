#
# PostgreSQL for puppetDB
#

class puppetdb::postgres {

  class { 'postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/32',
    ip_mask_allow_all_users    => '0.0.0.0/0',
    listen_addresses           => '127.0.0.1',
    ipv4acls                   => ['hostssl all johndoe 192.168.0.0/24 cert'],
    postgres_password          => 'puppetdb',
  }
  package { 'postgresql-contrib':
    ensure   => 'installed',
  }

  postgresql::server::role { 'puppetdb':
    password_hash => postgresql_password('puppetdb', 'puppetdb'),
  }
  postgresql::server::db { 'puppetdb':
    user     => 'puppetdb',
    password => postgresql_password('puppetdb', 'puppetdb'),
    notify  => Service['puppetdb'];
  }
  postgresql::server::database_grant { 'puppetdb':
    privilege => 'ALL',
    db        => 'puppetdb',
    role      => 'puppetdb',
    notify    => Service['puppetdb'];
  }

  $create_pg_trgm_cmd = "/usr/bin/psql puppetdb -c 'create extension pg_trgm'"
  exec { 'create_pg_trgm':
    command => "${create_pg_trgm_cmd}",
    user    => 'postgres',
    unless  => "/usr/bin/psql -d puppetdb -c '\\dx' | grep pg_trgm",
    require => Postgresql_psql['grant:database:puppetdb'],
    notify  => Service['puppetdb'];
  }
}
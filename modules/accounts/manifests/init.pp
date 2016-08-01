class accounts (){

  # Switch-off password prompt for group 'admin'
  file {'/etc/sudoers.d/admin':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0440',
    content => '%admin ALL=(ALL) NOPASSWD: ALL',
  }

  # Creating accounts
  create_resources('accounts::virtual', hiera_hash('users'))

}

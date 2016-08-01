# Define: includeRole
#
define includeRole () {
  include $name
}

node default {

  $assigned_roles = hiera_array('roles')
  includeRole {$assigned_roles: }

}

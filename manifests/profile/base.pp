class site::profile::base(
  $ssh_authorized_keys = {},
  $enable_loggly = false,
  $loggly_token = undef
) inherits ::site::params {

  require ::ntp
  require ::site::profile

  validate_hash($ssh_authorized_keys)
  validate_bool($enable_loggly)

  unless 'linux' != $::kernel {
    require ::sysdig
    require ::pe_mco_shell_agent
  }

  if $enable_loggly {
    validate_re($loggly_token, '^.+$')
    class { '::loggly::rsyslog': customer_token => $loggly_token, }
  }

  $ssh_authorized_keys_defaults = {}
  create_resources('ssh_authorized_key', $ssh_authorized_keys, $ssh_authorized_keys_defaults)
}
        


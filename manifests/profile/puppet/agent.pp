class site::profile::puppet::agent(
  $master = 'puppet',
  $environment = 'production',
  $is_enterprise = true
) inherits ::site::params {

  multi_validate_re($master, $environment, '^.+$')
  validate_bool($is_enterprise)

  require ::site::profile::base

  ini_setting { "puppet agent's master":
    ensure => present,
    path => "${::settings::confdir}/puppet.conf}",
    section => 'agent',
    setting => 'server',
    value => $master,
  }

  ini_setting { "puppet agent's environment":
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'agent',
    setting => 'environment',
    value => $environment,
  }
}

class site::profile::puppet::agent(
  $master = 'puppet',
  $environment = 'production'
) inherits ::site::params {

  validate_string($master, $environment)

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

  notify { '::site::profile::puppet::agent': }
}

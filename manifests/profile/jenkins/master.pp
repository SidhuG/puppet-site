class site::profile::jenkins::master(
  $plugins = {}
) inherits ::site::params {
  require ::site::profile::jenkins

  validate_hash($plugins)

  # puppetlabs/firewall appears to be broken for CentOS7/systemd right now
  class { '::firewall': ensure => stopped, }
  class { '::jenkins': configure_firewall => true, }

  include ::git

  $jenkins_plugins_defaults = {}
  create_resources('jenkins::plugin', $plugins, $jenkins_plugins_defaults)
}

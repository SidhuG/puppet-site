class site::profile::jenkins::master(
  $plugins = {},
  $jobs = {},
) inherits ::site::params {
  require ::site::profile::jenkins

  validate_hash($plugins, $jobs)

  # puppetlabs/firewall appears to be broken for CentOS7/systemd right now
  class { '::jenkins': 
    configure_firewall => true,
    job_hash => $jobs,
  }

  include ::git

  $jenkins_plugins_defaults = {}
  create_resources('jenkins::plugin', $plugins, $jenkins_plugins_defaults)
}

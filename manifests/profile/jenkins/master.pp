class site::profile::jenkins::master(
  $plugins = {},
  $jobs = {},
  $jenkins_job_builder_configs = {}
) inherits ::site::profile::jenkins::master::params {

  require ::site::profile::jenkins

  validate_hash($plugins, $jobs, $jenkins_job_builder_configs)

  include ::git

  ensure_packages( $packages, { 'ensure' => 'installed', } )

  if 'RedHat' == $::osfamily {
    exec { "install yum group 'Development Tools'":
      command => "/bin/yum groupinstall 'Development Tools' -y",
    }
  }
    
  class { '::jenkins': configure_firewall => true, plugin_hash => $plugins, }
  $jobs_defaults = { require => Class[::jenkins], }
  create_resources('::jenkins::job', $jobs, $jobs_defaults)

  class { '::jenkins_job_builder':
    jobs => $jenkins_job_builder_configs,
    require => Class[::jenkins],
  }
}

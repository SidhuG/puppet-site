class site::profile::jenkins::master(
  $plugins = {},
  $jobs = {},
  $jjb_pipelines = {}
) inherits ::site::profile::jenkins::master::params {

  require ::site::profile::jenkins

  validate_hash($plugins, $jobs, $jjb_pipelines)

  include ::git
  include ::rbenv
  include ::jenkins_job_builder

  User <| title == $jenkins_user |> {
    groups +> $docker_group,
    notify +> Class[::jenkins::service],
  }

  class { '::docker': dns => $::resolve_config_nameservers, } ->
  docker::image { 'jpetazzo/nsenter': ensure => latest, } ->

  exec { 'install docker nsenter':
    path => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    command => 'docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter',
    refreshonly => true,
  }

  ensure_packages( $packages, { 'ensure' => 'installed', } )

  if 'RedHat' == $::osfamily {
    exec { "install yum group 'Development Tools'":
      command => "/bin/yum groupinstall 'Development Tools' -y",
      unless => "/bin/yum grouplist 'Development Tools' | egrep 'Installed groups'",
    }
  }

  Rbenv::Gem { ruby_version => '2.1.2', }
  ::rbenv::plugin { 'sstephenson/ruby-build': } ->
  ::rbenv::build { '2.1.2': global => true, } ->
  ::rbenv::gem { 'rake': }

  $plugins_real = merge($default_plugins, $plugins)
  class { '::jenkins': configure_firewall => true, plugin_hash => $plugins_real, }

  $jobs_defaults = { require => Class[::jenkins], }
  create_resources('::jenkins::job', $jobs, $jobs_defaults)

  $jjb_pipelines_defaults = {}
  create_resources(
    '::site::profile::jenkins::master::pipeline',
    $jjb_pipelines,
    $jjb_pipelines_defaults
  )
}

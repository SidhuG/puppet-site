class site::profile::puppet::master(
  $enable_r10k = true,
  $enable_autosign = false,
  $autosign_rules = undef,
  $enable_directory_environments = true,
  $directory_environments_path = $::site::profile::puppet::master::params::directory_environments_path,
  $hiera_config = $::site::profile::puppet::master::params::hiera_config,
  $service_name = $::site::profile::puppet::master::params::service_name,
  $time_zone = undef
) inherits ::site::profile::puppet::master::params {

  validate_bool($enable_r10k, $enable_autosign, $enable_directory_environments)
  validate_absolute_path($directory_environments_path, $hiera_config)
  multi_validate_re($service_name, '^.+$')
  if $time_zone { validate_re($timezone, '^.+$') }
  
  require ::site::profile::base

  # make this absolute when #PUP-1339 is fixed. 
  if $enable_r10k { include ::r10k }

  if $enable_autosign {
    validate_re($autosign_rules, '^.+$')
    
    file { "${::settings::confdir}/autosign.conf":
      ensure => file,
      content => $real_autosign_rules,
      owner => 'root',
      group => 'root',
      mode => '0644',
    }
  }

  # make this absolute: PUP-1339
  if $enable_directory_environments { include ::site::profile::puppet::master::direnvironments }

  ini_setting { 'Puppet master hiera_config setting':
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'master',
    setting => 'hiera_config',
    value => $hiera_config, 
  }

  if $time_zone {
    file_line { 'set the Puppet Dashboard Console timezone':
      ensure => present,
      path => "${::settings::confdir}/../puppet-dashboard/settings.yml",
      line => "time_zone: \'${time_zone}\'",
    }

    #FIXME1: detect Open Source or PE Dashboard
    #FIXME: notify service for restart
  }

  Service <| name == $service_name |> { subscribe +> Ini_setting['Puppet master hiera_config setting'], }
}

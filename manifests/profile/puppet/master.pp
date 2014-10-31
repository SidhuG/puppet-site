class site::profile::puppet::master(
  $enable_r10k = true,
  $enable_autosign = false,
  $autosign_rules = undef,
  $enable_directory_environments = true,
  $directory_environments_path = $::site::profile::puppet::master::params::directory_environments_path,
  $hiera_config = $::site::profile::puppet::master::params::hiera_config,
  $service_name = $::site::profile::puppet::master::params::service_name
) inherits ::site::profile::puppet::master::params {

  validate_bool($enable_r10k, $enable_autosign, $enable_directory_environments)
  validate_absolute_path($directory_environments_path, $hiera_config)
  multi_validate_re($service_name, '^.+$')
  
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

  Service <| name == $service_name |> { subscribe +> Ini_setting['Puppet master hiera_config setting'], }
}

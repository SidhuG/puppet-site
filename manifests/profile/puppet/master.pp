class site::profile::puppet::master(
  $is_enterprise = true,
  $enable_r10k = true,
  $enable_autosign = false,
  $autosign_rules = undef,
  $enable_directoryenvironments = true,
  $directoryenviornments_path = $::site::profile::puppet::master::params
) inherits ::site::profile::puppet::master::params {

  validate_bool($is_enterprise, $enable_r10k, $enable_autosign, $enable_directoryenvironments)
  
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
  if $enable_directoryenvironments { contain site::profile::puppet::master::direnvironments }
}

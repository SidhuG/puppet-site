class site::profile::puppet::master::r10k {
 
  $is_enterprise = $::site::profile::puppet::master::is_enterprise
  validate_bool($is_enterprise)

  $gem_provider = $is_enterprise ? {
    true => 'pe_gem',
    false => 'gem',
  }

  package { 'r10k':
    ensure => installed,
    provider => $gem_provider,
  }
}

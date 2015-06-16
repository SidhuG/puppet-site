class site::profile::puppet::master(
  $enable_r10k = true,
) inherits ::site::params {

  validate_bool($enable_r10k)

  require ::site::profile::base

  require ::git
  unless false == $enable_r10k { require ::r10k }

  $environments_dir = '/etc/puppetlabs/puppet/environments'
  file { $environments_dir:
    ensure => directory,
    mode => 0755,
    owner => 'root',
    group => 'root',
  }

  file { 'hiera router config':
    ensure => link,
    path => '/etc/puppetlabs/puppet/hiera.yaml',
    target => '/etc/puppetlabs/puppet/environments/production',
    notify => Service['pe-puppetmaster'],
  }
}

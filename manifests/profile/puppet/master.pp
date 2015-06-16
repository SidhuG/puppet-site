class site::profile::puppet::master(
  $enable_r10k = true,
) inherits ::site::params {

  validate_bool($enable_r10k)

  require ::site::profile::base

  require ::git
  unless false == $enable_r10k { require ::r10k }

  $environments_dir = '/etc/puppetlabs/puppet/environments'
  ensure_resource($environments_dir, { 'ensure' => 'directory' })

  file { 'hiera router config':
    ensure => link,
    path => '/etc/puppetlabs/puppet/hiera.yaml',
    target => '/etc/puppetlabs/puppet/environments/production',
    notify => Service['pe-puppetmaster'],
  }

  require ::grafanadash::dev
}

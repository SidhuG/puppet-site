class site::profile::puppet::master::direnvironments(
  $directory_environments_path = $::site::profile::puppet::master::directory_environments_path
) inherits ::site::profile::puppet::master::params {

  validate_absolute_path($directory_environments_path)
 
  ini_setting { 'set Puppet directory-based environments path':
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'master',
    setting => 'environmentpath',
    value => $directory_environments_path,
  }

  if !defined(File[$directory_environments_path]) {
    file { $directory_environments_path:
      ensure => directory,
      owner => 'root',
      group => 'root',
      mode => '0640',
    }
  }
}

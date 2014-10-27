class site::profile::puppet::master::direnvironments(
  $environmentspath = $::site::profile::puppet::master::directoryenvironments_path
) {
  validate_absolute_path($environmentspath)
 
  ini_setting { 'set Puppet directory-based environments path':
    ensure => present,
    path => "${::settings::confdir}/puppet.conf",
    section => 'master',
    setting => 'environmentpath',
    value => $environmentspath,
  }

  if !defined(File[$environmentspath]) {
    file { 'Puppet environments directory':
      ensure => directory,
      path => $environmentspath,
      owner => 'root',
      group => 'root',
      mode => '0600',
    }
  }
}

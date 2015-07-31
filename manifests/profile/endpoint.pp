class site::profile::endpoint(

) inherits ::site::profile::endpoint::params {

  require ::site::profile::base
  require ::epel

  exec { "install XFCE":
    path => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    command => 'yum -y groups install "Xfce"',
    unless => 'rpm -qa | grep -i xfce',
  }

  package { ['x2goserver', 'x2goserver-xsession'] : ensure => installed, }

}

class site::profile::jenkins::master::params inherits ::site::params {

  case $::osfamily {
    'RedHat': {
      $packages = [ 
        'rubygem-bundler',
        'ruby-devel',
        'libxml2-devel'
      ]
    }
    default: {fail("OS family ${::osfamily} not supported!")}
  }

}

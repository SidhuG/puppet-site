class site::profile::puppet inherits ::site::params { 
  require ::site::profile
  notify { '::site::profile::puppet': }
}

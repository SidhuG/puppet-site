class site::profile inherits ::site::params {
  require ::site
  notify { '::site::profile': }
}

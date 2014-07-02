class site::role inherits ::site::params {
  require ::site
  notify { '::site::role': }
}

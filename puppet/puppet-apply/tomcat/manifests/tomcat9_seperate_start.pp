tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9_base',
  service_name   => 'tomcat9',
  service_ensure => 'running',
}

notify { 'tomcat9 installed...':
  require => Tomcat::Service['default'],
}

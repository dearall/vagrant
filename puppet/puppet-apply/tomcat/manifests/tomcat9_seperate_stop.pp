# stop tomcat service
tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9_base',
  service_name   => 'tomcat9',
  service_ensure => 'stopped',
}

notify { 'tomcat9 stopped...':
  require => Tomcat::Service['default'],
}

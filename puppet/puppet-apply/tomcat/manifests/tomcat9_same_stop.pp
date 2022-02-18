# stop tomcat service
tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9',
  service_name   => 'tomcat9',
  service_ensure => 'stopped',
  java_home      => '/usr/lib/jvm/jdk-11.0.13+8',
}


notify { 'tomcat9 stopped...':
  require => Tomcat::Service['default'],
}

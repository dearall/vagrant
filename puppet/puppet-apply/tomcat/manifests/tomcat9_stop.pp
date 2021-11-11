# stop tomcat service
tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9',
  service_ensure => 'stopped',
}

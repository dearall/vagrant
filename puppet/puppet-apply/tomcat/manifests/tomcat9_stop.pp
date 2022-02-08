# stop tomcat service
tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
# catalina_base  => '/opt/tomcat9_base',
  service_ensure => 'stopped',
}

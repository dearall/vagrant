# h2 scheme table create
class h2_schema {
  exec { 'create_schema':
    command => 'java -cp /tmp/files/h2-2.1.210.jar org.h2.tools.RunScript -url jdbc:h2:~/todo -user sa -script /tmp/files/todo-schema.sql',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/lib/jvm/jdk-11.0.13+8/bin',
    user    => 'tomcat',
  }
}

include 'h2_schema'

notify { 'todo-scheme installed ...':}

tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9_base',
  service_name   => 'tomcat9',
  service_ensure => 'running',
}

notify { 'tomcat9 installed...':
  require => Tomcat::Service['default'],
}

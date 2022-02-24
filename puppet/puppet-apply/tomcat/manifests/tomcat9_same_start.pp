# h2 scheme table create
class h2_schema { # lint:ignore:autoloader_layout
  exec { 'create_schema':
    command => 'java -cp /home/tomcat/h2/h2-2.1.210.jar org.h2.tools.RunScript -url jdbc:h2:~/todo -user sa -script /home/tomcat/h2/todo-schema.sql', # lint:ignore:140chars
    path    => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/lib/jvm/jdk-11.0.13+8/bin',
    user    => 'tomcat',
  }
}

include 'h2_schema'

notify { 'todo-scheme installed ...':}

# CATALINA_HOME environment
file_line { 'catalina_home':
  path  => '/etc/profile',
  line  => 'export CATALINA_HOME=/opt/tomcat9',
  match => '^export\ CATALINA_HOME\=',
}

# CATALINA_BASE environment
file_line { 'catalina_base':
  path  => '/etc/profile',
  line  => 'export CATALINA_BASE=/opt/tomcat9',
  match => '^export\ CATALINA_BASE\=',
}


# start tomcat service
tomcat::service { 'default':
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9',
  service_name   => 'tomcat9',
  service_ensure => 'running',
  java_home      => '/usr/lib/jvm/jdk-11.0.13+8',
}

notify { 'tomcat9 running ...':
  require => Tomcat::Service['default'],
}

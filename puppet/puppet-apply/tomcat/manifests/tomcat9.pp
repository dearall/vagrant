# group { 'tomcat' :
#   ensure => 'present',
# }
# user { 'tomcat' :
#   ensure     => 'present',
#   gid        => 'tomcat',
#   managehome => true,
#   require    => Group['tomcat']
# }

tomcat::instance { 'default':
  source_url     => 'https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz',
  catalina_home  => '/opt/tomcat9',
# catalina_base  => '/opt/tomcat9_base',
  manage_service => true,
}

notify { 'tomcat9 installed...':
  require => Tomcat::Instance['default'],
}

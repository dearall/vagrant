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
  source_url     => 'https://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz',
  catalina_home  => '/opt/tomcat9',
  catalina_base  => '/opt/tomcat9',
  manage_service => true,
}

notify { 'tomcat9 installed...':
  require => Tomcat::Instance['default'],
}

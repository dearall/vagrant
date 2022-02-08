# 通过 puppetlabs-tomcat 6.1.1 模块安装 tomcat9
class tomcat9 {
  group { 'tomcat' :
    ensure => 'present',
  }
  user { 'tomcat' :
    ensure     => 'present',
    gid        => 'tomcat',
    managehome => true,
    require    => Group['tomcat']
  }
  tomcat::install { '/opt/tomcat9':
    source_url => 'https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz',
    require    => User['tomcat']
  }
  tomcat::instance { 'default':
    catalina_home  => '/opt/tomcat9',
  # catalina_base  => '/opt/tomcat9_base',
    manage_service => true,
    service_name   => 'tomcat9',
    require        => Tomcat::Install['/opt/tomcat9'],
  }

  notify { 'tomcat9 installed...':}
}

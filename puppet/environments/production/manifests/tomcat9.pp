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
    source_url    => 'https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz',
    catalina_home => '/opt/tomcat9',
    require       => User['tomcat']
  }
  tomcat::service { 'default':
    service_ensure => 'stopped',
    service_name   => 'tomcat9',
  }

  notify { 'Installing tomcat9...':}
}

# Class['adoptjdk11'] -> Class['tomcat9']

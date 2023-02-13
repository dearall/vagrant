# adoptjdk11 定义
class adoptjdk11 {
    java::adopt { 'jdk11' :
    ensure  => 'present',
    version => '11',
    java    => 'jdk',
    url     => 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.18%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.18_10.tar.gz',
  }

  notify { 'Installing adoptjdk11...':}

  file { '/usr/lib/jvm/java':
      ensure  => link,
      path    => '/usr/lib/jvm/java',
      target  => '/usr/lib/jvm/jdk-11.0.18+10',
      require => Java::Adopt['jdk11'],
  }

  file_line { 'java_home':
    path    => '/etc/profile',
    line    => 'export JAVA_HOME=/usr/lib/jvm/java',
    require => File['/usr/lib/jvm/java'],
  }

  file_line { 'path_java':
    path  => '/etc/profile',
    line  => 'export PATH=$JAVA_HOME/bin:$PATH',
    match => '^export\ PATH\=',
  }

  group { 'tomcat' :
    ensure  => 'present',
    require => File_line['path_java'],
  }
  user { 'tomcat' :
    ensure     => 'present',
    gid        => 'tomcat',
    managehome => true,
    require    => Group['tomcat']
  }

  exec { 'source /etc/profile':
    command => "/usr/bin/bash -c 'source /etc/profile'",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    user    => 'tomcat',
  # require => File_line['path_java'],
    require =>  User['tomcat'],
  }

  notify { 'installing adoptjdk11 ...': }
}

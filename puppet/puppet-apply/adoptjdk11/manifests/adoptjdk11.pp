# adoptjdk11 定义
java::adopt { 'jdk11' :
    ensure  => 'present',
    version => '11',
    java    => 'jdk',
    url     => 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.18%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.18_10.tar.gz',
}

file { 'java':
    ensure  => link,
    path    => '/usr/lib/jvm/java',
    target  => '/usr/lib/jvm/jdk-11.0.18+10',
    require => Java::Adopt['jdk11'],
}

file_line { 'java_home':
  path    => '/etc/profile',
  line    => 'export JAVA_HOME=/usr/lib/jvm/java',
  require => File['java'],
}

file_line { 'path_java':
  path    => '/etc/profile',
  line    => 'export PATH=$JAVA_HOME/bin:$PATH',
  match   => '^export\ PATH\=',
  require => File_line['java_home'],
}

# tomcat user and group
group { 'tomcat' :
  ensure => 'present',
}
user { 'tomcat' :
  ensure     => 'present',
  gid        => 'tomcat',
  managehome => true,
  require    => Group['tomcat']
}

exec { 'source /etc/profile':
  command => "bash -c 'source /etc/profile'",
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
  user    => 'tomcat',
  require => File_line['path_java'],
}

notify { 'Installing adoptjdk11...':}

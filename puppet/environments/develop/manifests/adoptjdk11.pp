# adoptjdk11 定义
class adoptjdk11 {
    java::adopt { 'jdk11' :
    ensure  => 'present',
    version => '11',
    java    => 'jdk',
    url     => 'https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz',
  }

  notify { 'adoptjdk11 installed ...':
    require => Java::Adopt['jdk11'],
  }

  file_line { 'java_home':
    path    => '/etc/profile',
    line    => 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.13+8',
    require => Java::Adopt['jdk11'],
  }

  file_line { 'path_java':
    path    => '/etc/profile',
    line    => 'export PATH=$JAVA_HOME/bin:$PATH',
    match   => '^export\ PATH\=',
    require => File_line['java_home'],
  }

  exec { 'source /etc/profile':
    command => "/usr/bin/bash -c 'source /etc/profile'",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => File_line['path_java'],
  }
}

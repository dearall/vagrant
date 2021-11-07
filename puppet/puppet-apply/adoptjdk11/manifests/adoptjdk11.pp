# adoptjdk11 定义
java::adopt { 'jdk11' :
    ensure  => 'present',
    version => '11',
    java    => 'jdk',
}

file_line { 'java_home':
  path => '/etc/profile',
  line => 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.2+9',
}

file_line { 'path_java':
  path  => '/etc/profile',
  line  => 'export PATH=$JAVA_HOME/bin:$PATH',
  match => '^export\ PATH\=',
}

notify { 'adoptjdk11 ':}

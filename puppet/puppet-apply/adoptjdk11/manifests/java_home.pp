# JAVA_HOME environment
file_line { 'java_home':
  path => '/etc/profile',
  line => 'export JAVA_HOME=/usr/lib/jvm/jdk-11.0.13+8',
}

file_line { 'path_java':
  path  => '/etc/profile',
  line  => 'export PATH=$JAVA_HOME/bin:$PATH',
  match => '^export\ PATH\=',
}

exec { 'source /etc/profile':
  command => "bash -c 'source /etc/profile'",
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
}

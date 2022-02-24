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

exec { 'source /etc/profile':
  command => "bash -c 'source /etc/profile'",
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
  user    => 'vagrant',
  require => File_line['path_java'],
}

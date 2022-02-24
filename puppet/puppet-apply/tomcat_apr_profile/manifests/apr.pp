# LD_LIBRARY_PATH environment
file_line { 'LD_LIBRARY_PATH':
  path  => '/etc/profile',
  line  => 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib:/opt/tomcat9/lib',
  match => '^export\ LD_LIBRARY_PATH\=',
}
file_line { 'LD_RUN_PATH':
  path  => '/etc/profile',
  line  => 'export LD_RUN_PATH=$LD_RUN_PATH:/usr/local/apr/lib:/opt/tomcat9/lib',
  match => '^export\ LD_RUN_PATH\=',
}

file { '/opt/tomcat9/bin/setenv.sh':
  ensure => present,
}

file_line { 'LD_LIBRARY_PATH_setenv':
  path    => '/opt/tomcat9/bin/setenv.sh',
  line    => 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib:/opt/tomcat9/lib',
  match   => '^export\ LD_LIBRARY_PATH\=',
  require => File['/opt/tomcat9/bin/setenv.sh'],
}


file_line { 'LD_RUN_PATH_setenv':
  path    => '/opt/tomcat9/bin/setenv.sh',
  line    => 'export LD_RUN_PATH=$LD_RUN_PATH:/usr/local/apr/lib:/opt/tomcat9/lib',
  match   => '^export\ LD_RUN_PATH\=',
  require => File['/opt/tomcat9/bin/setenv.sh'],
}

exec { 'source /etc/profile':
  command => "bash -c 'source /etc/profile'",
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
  user    => 'tomcat',
  require => File_line['LD_LIBRARY_PATH', 'LD_RUN_PATH'],
}

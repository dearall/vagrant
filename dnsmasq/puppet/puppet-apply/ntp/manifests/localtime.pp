# set local time zoneinfo
class localtime {
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Asia/Shanghai',
  }
}

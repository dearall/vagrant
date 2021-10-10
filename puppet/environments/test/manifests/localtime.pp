# 修改本地时区
class  localtime {
  file { '/etc/localtime':
    ensure => link,
    target => '/usr/share/zoneinfo/Asia/Shanghai',
  }
}

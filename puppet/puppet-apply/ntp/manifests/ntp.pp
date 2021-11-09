# client ntp
class { 'ntp':
  servers  => ['192.168.0.2 prefer','cn.ntp.org.cn'],
  restrict => [
    # By default, exchange time with everybody, but don't allow configuration.
    '-4 default notrap nomodify nopeer noquery',
    '-6 default notrap nomodify nopeer noquery',
    '127.0.0.1',
    '-6 ::1',

    #允许这个网段的对时请求
    '192.168.0.0 mask 255.255.255.0 nomodify',

    #允许上层ntp server的所有权限
    '192.168.0.2'
  ],
}

# 设置本地时区
file { '/etc/localtime':
  ensure => link,
  target => '/usr/share/zoneinfo/Asia/Shanghai',
}

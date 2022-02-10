# 本地时区
include localtime

# dns 客户端
# class { 'dnsclient':
#   dns               => '192.168.0.2',
#   dns_stub_listener => 'no',
# }

# dns 客户端
class { 'resolved':
  dns               => '192.168.0.2',
  domains           => 'sansovo.org',
  dns_stub_listener => 'yes',
  cache             => 'no-negative',
}

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

node /^tomcat(-|_)?\w*\.sansovo\.org$/ {
  include adoptjdk11
  include tomcat9
}

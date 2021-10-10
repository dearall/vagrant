# 本地时区
include localtime

# dns 客户端
class { 'dnsclient':
  dns               => '192.168.0.2',
  dns_stub_listener => 'yes',
}


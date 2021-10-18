# 本地时区
include localtime

# dns 客户端

# class { 'dnsclient':
#   dns               => '192.168.0.2',
#   domains           => 'sansovo.org',
#   dns_stub_listener => 'no',
# }

class { 'resolved':
  dns               => '192.168.0.2',
  domains           => 'sansovo.org',
  dns_stub_listener => 'no',
}


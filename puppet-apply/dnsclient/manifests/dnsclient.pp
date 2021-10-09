# Class:
# 'dnsclient':
#
class { 'dnsclient':
  dns          => '192.168.0.2',
  fallback_dns => '',
}

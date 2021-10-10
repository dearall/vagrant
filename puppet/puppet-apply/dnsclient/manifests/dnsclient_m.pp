class { 'dnsclient':
  dns               => '192.168.0.2',
  dns_stub_listener => 'yes',
}

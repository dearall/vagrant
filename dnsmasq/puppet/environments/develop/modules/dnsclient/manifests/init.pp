# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include dnsclient
class dnsclient ($dns, $dns_stub_listener) {
  file { '/etc/systemd/resolved.conf':
    ensure  => file,
    content => template('dnsclient/resolved.conf.erb'),
    notify  => Service['systemd-resolved'],
    backup  => true,
  }

  service { 'systemd-resolved':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/systemd/resolved.conf'],
  }

  file { '/etc/resolv.conf':
    ensure => link,
    target => '/run/systemd/resolve/resolv.conf',
  }
}

$dns = '192.168.0.2'
$fallback_dns = undef
$domains = 'sansovo.org'
$llmnr = 'no'
$multicast_dns = 'no'
$dnssec = 'no'
$dns_over_tls = 'no'
$cache = 'no-negative'
$dns_stub_listener = 'no'
$read_etc_hosts = 'yes'
$resolvedconf = @("RESOLVEDCONF")
                #  This file is part of systemd.
                #
                #  systemd is free software; you can redistribute it and/or modify it
                #  under the terms of the GNU Lesser General Public License as published by
                #  the Free Software Foundation; either version 2.1 of the License, or
                #  (at your option) any later version.
                #
                # Entries in this file show the compile time defaults.
                # You can change settings by editing this file.
                # Defaults can be restored by simply deleting this file.
                #
                # See resolved.conf(5) for details

                [Resolve]
                DNS=${dns}
                FallbackDNS=${fallback_dns}
                Domains=${domains}
                LLMNR=${llmnr}
                MulticastDNS=${multicast_dns}
                DNSSEC=${dnssec}
                DNSOverTLS=${dns_over_tls}
                Cache=${cache}
                DNSStubListener=${dns_stub_listener}
                ReadEtcHosts=${read_etc_hosts}
                | RESOLVEDCONF

# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include dnsclient
class dnsclient {
  file { '/etc/systemd/resolved.conf':
    ensure  => file,
    content => $::resolvedconf,
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

include dnsclient


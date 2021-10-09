$ip = '192.168.0.2'
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
                DNS=${ip}
                #FallbackDNS=
                #Domains=
                #LLMNR=no
                #MulticastDNS=no
                #DNSSEC=no
                #DNSOverTLS=no
                #Cache=no-negative
                DNSStubListener=no
                #ReadEtcHosts=yes
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
    content => $::resolvedconf,               # template('dnsclient/resolved.conf.erb'),
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

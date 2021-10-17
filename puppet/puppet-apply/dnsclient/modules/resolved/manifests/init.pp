# @summary Config the /etc/systemd/resolved.conf and /etc/resolv.conf simbol link to instruct systemd-resolved.service using dns server(s)
#
# resolved
#
# Main class, config the /etc/systemd/resolved.conf and relative systemd-resolved.service, as well as /etc/resolv.conf simbol link.
#
# @example
#   include resolved
#
# See resolved.conf(5) for details
#
# @param dns
#   A space-separated list of IPv4 and IPv6 addresses to use as system DNS servers. DNS requests are sent to one of the listed DNS servers 
#   in parallel to suitable per-link DNS servers acquired from systemd-networkd.service(8) or set at runtime by external applications.. 
#
#   Default value: undef.
#
# @param fallback_dns
#   A space-separated list of IPv4 and IPv6 addresses to use as the fallback DNS servers. Any per-link DNS servers obtained from systemd-
#   networkd.service(8) take precedence over this setting, as do any servers set via DNS= above or /etc/resolv.conf. This setting is hence
#   only used if no other DNS server information is known. If this option is not given, a compiled-in list of DNS servers is used instead.
#
#   Default value: undef.
#
# @param domains
#   A space-separated list of domains. These domains are used as search suffixes when resolving single-label host names (domain names which
#   contain no dot), in order to qualify them into fully-qualified domain names (FQDNs).
#
#   Default value: undef.
#
# @param llmnr
#   Takes a boolean argument or "resolve". Controls Link-Local Multicast Name Resolution support (RFC 4795[1]) on the local host. If true, 
#   enables full LLMNR responder and resolver support. If false, disables both. If set to "resolve", only resolution support is enabled, 
#   but responding is disabled.Takes a boolean argument or "resolve". Controls Link-Local Multicast Name Resolution support (RFC 4795[1]) 
#   on the local host. If true, enables full LLMNR responder and resolver support. If false, disables both. If set to "resolve", only 
#   resolution support is enabled, but responding is disabled. 
#
#   Default value: 'no'.
#
# @param multicast_dns
#   Takes a boolean argument or "resolve". Controls Multicast DNS support (RFC 6762[2]) on the local host. If true, enables full Multicast
#   DNS responder and resolver support. If false, disables both. If set to "resolve", only resolution support is enabled, but responding 
#   is disabled. Note that systemd-networkd.service(8) also maintains per-link Multicast DNS settings. Multicast DNS will be enabled on a
#   link only if the per-link and the global setting is on. Default is 'no'.
#
#   Default value: 'no'.
#
# @param dnssec
#   Takes a boolean argument or "allow-downgrade". If true all DNS lookups are DNSSEC-validated locally (excluding LLMNR and Multicast 
#   DNS). If the response to a lookup request is detected to be invalid a lookup failure is returned to applications. Note that this mode
#   requires a DNS server that supports DNSSEC. If the DNS server does not properly support DNSSEC all validations will fail. If set to 
#   "allow-downgrade" DNSSEC validation is attempted, but if the server does not support DNSSEC properly, DNSSEC mode is automatically
#   disabled. Note that this mode makes DNSSEC validation vulnerable to "downgrade" attacks, where an attacker might be able to trigger
#   a downgrade to non-DNSSEC mode by synthesizing a DNS response that suggests DNSSEC was not supported. If set to false, DNS lookups
#   are not DNSSEC validated.
#   Note that DNSSEC validation requires retrieval of additional DNS data, and thus results in a small DNS look-up time penalty.
#   DNSSEC requires knowledge of "trust anchors" to prove data integrity. The trust anchor for the Internet root domain is built into
#   the resolver, additional trust anchors may be defined with dnssec-trust-anchors.d(5).
#
#   Default value: 'no'.
#
# @param dns_over_tls
#   Takes a boolean argument or "opportunistic". If true all connections to the server will be encrypted. Note that this mode requires
#   a DNS server that supports DNS-over-TLS and has a valid certificate for it's IP. If the DNS server does not support DNS-over-TLS all
#   DNS requests will fail. When set to "opportunistic" DNS request are attempted to send encrypted with DNS-over-TLS. If the DNS server
#   does not support TLS, DNS-over-TLS is disabled. Notethat this mode makes DNS-over-TLS vulnerable to "downgrade" attacks, where an 
#   attacker might be able to trigger a downgrade to non-encrypted mode by synthesizing a response that suggests DNS-over-TLS was not 
#   supported. If set to false, DNS lookups are send over UDP.
#
#   Note that DNS-over-TLS requires additional data to be send for setting up an encrypted connection, and thus results in a small DNS
#   look-up time penalty.
#
#   Note that in "opportunistic" mode the resolver is not capable of authenticating the server, so it is vulnerable to "man-in-the-middle"
#   attacks.
#
#   Server Name Indication (SNI) can be used when opening a TLS connection. Entries in DNS= should be in format "address#server_name".
#
#   In addition to this global DNSOverTLS setting systemd-networkd.service(8) also maintains per-link DNSOverTLS settings. For system
#   DNS servers (see above), only the global DNSOverTLS setting is in effect. For per-link DNS servers the per-link setting is in effect,
#   unless it is unset in which case the global setting is used instead.
#
#   Default value: 'no'.
#
# @param 
#   Takes a boolean or "no-negative" as argument. If "yes", resolving a domain name which already got queried earlier will return the
#   previous result as long as it is still valid, and thus does not result in a new network request. Be aware that turning off caching
#   comes at a performance penalty, which is particularly high when DNSSEC is used.
#
#   If "no-negative" (the default), only positive answers are cached.
#
#   Note that caching is turned off implicitly if the configured DNS server is on a host-local IP address (such as 127.0.0.1 or ::1),
#   in order to avoid duplicate local caching.
#
#   Default value: 'no-negative'
#
# @param dns_stub_listener
#   Takes a boolean argument or one of "udp" and "tcp". If "udp", a DNS stub resolver will listen for UDP requests on address 127.0.0.53
#   port 53. If "tcp", the stub will listen for TCP requests on the same address and port. If "yes" (the default), the stub listens for 
#   both UDP and TCP requests. If "no", the stub listener is disabled.
#
#   Note that the DNS stub listener is turned off implicitly when its listening address and port are already in use.
#
#   Default value: 'yes'
#
# @param read_etc_hosts
#   Takes a boolean argument. If "yes" (the default), the DNS stub resolver will read /etc/hosts, and try to resolve hosts or address by
#   using the entries in the file before sending query to DNS servers.
#
#   Default value: 'yes'
#
class resolved (
  Optional[String] $dns,
  Optional[String] $fallback_dns,
  Optional[String] $domains,
  Optional[Variant[Boolean, Enum['yes','no','resolve']]] $llmnr,
  Optional[Variant[Boolean, Enum['yes','no','resolve']]] $multicast_dns,
  Optional[Variant[Boolean, Enum['yes','no','allow-downgrade']]] $dnssec,
  Optional[Variant[Boolean, Enum['yes','no','opportunistic']]] $dns_over_tls,
  Optional[Variant[Boolean, Enum['yes','no','no-negative']]] $cache,
  Optional[Variant[Boolean, Enum['yes','no','udp', 'tcp']]] $dns_stub_listener,
  Optional[Variant[Boolean, Enum['yes','no']]] $read_etc_hosts,
) {
    file { '/etc/systemd/resolved.conf':
    ensure  => file,
    content => template('resolved/resolved.conf.erb'),
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

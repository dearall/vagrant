# resolved

## Table of Contents

- [resolved](#resolved)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Setup](#setup)
    - [What resolved affects](#what-resolved-affects)
    - [Beginning with resolved](#beginning-with-resolved)
  - [Usage](#usage)
    - [Using default parameters](#using-default-parameters)
    - [I want use my own local network dns server](#i-want-use-my-own-local-network-dns-server)
    - [I want use my own local network dns server, and public dns](#i-want-use-my-own-local-network-dns-server-and-public-dns)
    - [Install `resolved` module on the same machine which the dns server running](#install-resolved-module-on-the-same-machine-which-the-dns-server-running)
  - [Reference](#reference)
  - [Limitations](#limitations)
  - [Development](#development)
  - [Release Notes](#release-notes)

## Description

The resolved module configures the /etc/systemd/resolved.conf and /etc/resolv.conf simbol link, manages the systemd-resolved service to use the indicated dns server(s).

## Setup

### What resolved affects

- This module alters the /etc/systemd/resolved.conf file contents, and alters the /etc/resolv.conf symbol link target to /run/systemd/resolve/resolv.conf.

- The `dns` parameter is a space-separated list of IPv4 and IPv6 addresses to use as system DNS servers. The ip
addresses in this list up to three, the extra ip addresses are ignored.

### Beginning with resolved

`include resolved` is enough to get you up and running, this uses the **default** parameters to run resolved module. To pass in parameters specifying which dns server(s) to use:

```puppet
class { 'resolved':
  dns => '192.168.0.2 211.137.160.5',
}
```

NOTE: In this example, `192.168.0.2` is the local network dns server ip, and `211.137.160.5` is the public dns server ip address.

## Usage

All parameters for the **resolved** module are contained within the main `resolved` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Using default parameters

```puppet
include resolved
```

### I want use my own local network dns server

```puppet
class { 'resolved':
  dns => '192.168.0.2',
}
```

### I want use my own local network dns server, and public dns

set two or three dns servers: one or two for local network dns server, other(s) for public dns.

```puppet
class { 'resolved':
  dns => '192.168.0.2 211.137.160.5',
}
```

### Install `resolved` module on the same machine which the dns server running

If you install `resolved` module on the samle machine which the dns server installed, set `dns_stub_listener` parameter to 'no', because they may listen on the same dns default netword port: 53.

```puppet
class { 'resolved':
  dns               => '192.168.0.2',
  dns_stub_listener => 'no',
}
```

## Reference

See [REFERENCE.md](https://github.com/dearall/devalone-resolved/blob/master/REFERENCE.md)

## Limitations

This module has been tested on Open Source Puppet 7. It is tested on ubuntu 20.04.

For an extensive list of supported operating systems, see metadata.json

## Development

[github https://github.com/dearall/devalone-resolved](https://github.com/dearall/devalone-resolved)

## Release Notes

2021-10-18, version 1.0.0 released.
2021-10-19, version 1.1.0 released.

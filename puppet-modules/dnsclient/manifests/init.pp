# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include dnsclient
class dnsclient ($dns) {
  file { '/etc/systemd/resolved.conf':
    ensure  => file,
    content => template('dnsclient/resolved.conf.erb')
  }
}

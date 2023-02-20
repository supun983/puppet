class arpwatch_vlans {
  $emails = hiera_array('emails')
  $iface = hiera_array('arpwatch_vlans')

  package { 'arpwatch':
    ensure   => '2.1a15-7',
    provider => 'apt',
  }

  # Configuration file
  $iface.each |String $iface| {
    file { "/etc/arpwatch/${iface}.iface":
      content => "IFACE_ARGS=\"-m ${emails.join(',')}\"\n",
      ensure => present,
      owner => 'root',
      mode => '0644',
      notify => Service["arpwatch@${iface}.service"],
    }
  }

  #arpwatch service
  $iface.each |String $iface| {
    service { "arpwatch@${iface}.service":
      ensure => 'running',
      enable => 'true',
      subscribe => Package['arpwatch'],
    }
  }
}

# Interfaces
$iface = [
  'eth0',
  'vlan100',
]

# email alerts
$email_addresses = [
  'supun983@gmail.com',
  'supun.wickramatilake@exactprosystems.com',
  'supunw@gmail.com',
]

# Remove unmanaged files in /etc/arpwatch
$iface.each |String $iface| {
  file { "/etc/arpwatch/${iface}.iface":
    ensure  => present,
    owner   => 'root',
    mode    => '0644',
    content => "IFACE_ARGS=\"-m ${email_addresses.join(',')}\"\n",
    notify  => Service["arpwatch@${iface}.service"],
  }
}

#Arpwatch installation
package { 'arpwatch':
  ensure   => '2.1a15-7',
  provider => 'apt',
}

#arpwatch service
$iface.each |String $iface| {
  service { "arpwatch@${iface}.service":
    ensure    => 'running',
    enable    => 'true',
    subscribe => Package['arpwatch'],
  }
}

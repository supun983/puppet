# Interfaces
$iface = [
'eth0',
'vlan101',
]


# email alerts
$email_addresses = [ 
  'supun983@gmail.com',
  'supun.wickramatilake@exactprosystems.com',
  'supunw@gmail.com',
]

#Arpwatch installation
package { 'arpwatch':
  ensure   => '2.1a15-7',
  provider => 'apt',
}


# Configuration file
$iface.each |String $iface| {
file { "/etc/arpwatch/${iface}.iface":
content => "IFACE_ARGS=\"-m ${email_addresses.join(',')}\"\n",
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

# Define interfaces list
$original_interfaces = [
  'eth0',
  'eth1',
  'eth2',
]

# List of emaisl
$emails = [
  'supun983@gmail.com',
  'supun.wickramatilake@exactprosystems.com',
  'supunw@gmail.com',
]

#Arpwatch installation
package { 'arpwatch':
  ensure   => '2.1a15-7',
  provider => 'apt',
}

# Create a separate configuration file for each interface
$interfaces.each |String $iface| {
  file { "/etc/arpwatch/#{$iface}.iface":
    content => template("module/arpwatch.#{$iface}.iface.erb"),
    notify  => Service['arpwatch'],
  }
}

#arpwatch service
service { 'arpwatch':
  ensure   => 'running',
  enable   => 'true',
  provider => 'debian',
}

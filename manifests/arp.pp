# Define interfaces list
$interfaces = [
  'eth0',
  'eth1',
  'eth2',
]

# List of emaisl
$emails = [
  'user1@example.com',
  'user2@example.com',
  'user3@example.com',
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

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
file { "/etc/arpwatch/#{$iface}.iface":
  content => "interface: #{$iface}\nmail-to: #{$email_addresses.join(', ')}\n",
  ensure => present,
  owner => 'root',
  mode => '0644',
  notify  => Service['arpwatch'],
}

#arpwatch service
service { 'arpwatch':
  ensure   => 'running',
  enable   => 'true',
  provider => 'debian',
}

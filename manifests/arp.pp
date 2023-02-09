$iface = [
  'eth0',
]

# List of emails
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

# Create a separate configuration file for each interface
$iface.each |String $iface| {
  file { "/etc/arpwatch/$iface.iface":
    content => "IFACE_ARGS='-m $email_addresses\n",
    ensure => present,
    owner => 'root',
    mode => '0644',
    notify  => Service['arpwatch'],
  }
}

#arpwatch service
service { 'arpwatch':
  ensure   => 'running',
  enable   => 'true',
  subscribe  => Package['arpwatch'],
}

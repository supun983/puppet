#Arpwatch installation
package { 'arpwatch':
  ensure   => '2.1a15-7',
  provider => 'apt',
}
#arpwatch service
service { 'arpwatch':
  ensure   => 'running',
  enable   => 'true',
  provider => 'debian',
}

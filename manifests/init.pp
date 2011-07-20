class uwca {
  package { 'ca-certificates':
    ensure => present,
  }

  file { '/usr/local/share/ca-certificates':
    ensure => directory,
  }

  file { '/usr/local/share/ca-certificates/UW_Services_CA.crt':
    source => 'puppet:///uwca/UW_Services_CA.crt',
    require => Package['ca-certificates'],
  }

  file { '/etc/ssl/certs/UW_Services_CA.pem':
    ensure => link,
    target => '/usr/local/share/ca-certificates/UW_Services_CA.crt',
    notify => Exec['/usr/bin/c_rehash /etc/ssl/certs'],
  }

  exec { '/usr/bin/c_rehash /etc/ssl/certs':
    refreshonly => true,
  }
}

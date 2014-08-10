class  build {

  # Remember this box needs ruby v 1.9.3
  # Therefore Software collections
  # Therefore scl enable ruby193 "bash" before trying to build omnibus etc

  package {'patch': ensure => present }
  package { 'centos-release-SCL':
    ensure => '6-5.el6.centos',
  }
  package { 'ruby193':
    ensure  => '1-11.el6.centos.alt',
    require => Package['centos-release-SCL']
  }
  package { 'ruby193-ruby-devel':
    ensure => '1.9.3.448-40.1.el6.centos.alt',
  }
  package { 'gcc-c++':
    ensure => '4.4.7-4.el6',
  }

  package { 'rubygem-fpm':
    ensure => '1.2.0-1',
  }

  package { 'rpm-build':
    ensure => '4.8.0-37.el6',
  }



}



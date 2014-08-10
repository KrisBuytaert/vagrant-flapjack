  class our_icinga {


    Exec {
      path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    }
    # After the intallation of the icinga server this stanza needs to move to the icinga monitoring profiles
    # that should be included in all nodes by default

    if $::hostname =~ /icinga/ {
      $is_icinga_server  = true
    }
    else 
    {
      $is_icinga_server  = false
    }


    class{'::icinga':
      server                => $is_icinga_server,
      nrpe_allowed_hosts    => '192.168.99.103',
      plugins               => ['pnp4nagios','checkload','checkssh'],
      collect_ipaddress     => $::fqdn,
      hostgroups            => 'default',
      notification_period   => '24x7',
      notifications_enabled => '1',
    }


    #    class{'::icinga::plugins::checkntp':
    #  ntp_server => hiera('ntp_server'),
    #}

    firewall{'010 nrpe':
      dport  => '5666',
      source => '192.168.99.103',
      action => 'accept',
      tag    => 'firewall',
    }


    include ::epel

    yumrepo { 'inuits':
      baseurl  => 'http://repo.inuits.eu/pulp/inuits/$releasever/$basearch',
      descr    => 'CentOS-$releasever - Inuits',
      enabled  => '1',
      gpgcheck => '0',
    }

    sudo::conf{'nrpe':
      content => "Defaults:nagios !requiretty\nnagios ALL=(ALL) NOPASSWD:/usr/lib/nagios/plugins/check_disk,/usr/lib64/nagios/plugins/check_disk,/usr/lib/nagios/plugins/check_mailq,/usr/lib64/nagios/plugins/check_mailq,/usr/lib64/nagios/plugins/check_puppetmaster.sh\n",
    }

    sudo::conf{'vagrant':
      content => "Defaults:vagrant !requiretty\nvagrant        ALL=(ALL)       NOPASSWD: ALL",
    }

}


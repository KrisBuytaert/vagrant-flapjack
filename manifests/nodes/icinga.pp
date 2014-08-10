  node icinga {


    include our_icinga 
    Exec {
      path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    }


    #  Setting up httpd etc.

    firewall{'010 http 80':
      dport  => '80',
      action => 'accept',
    }

    include ::apache



    Icinga::User {
      ensure                        => present,
      hash                          => true,
      can_submit_commands           => '1',
      contactgroups                 => 'admins',
      host_notifications_enabled    => '0',
      service_notifications_enabled => '0',
    }

    icinga::user{'sdog':
      email                         => 'sdog@inuits.eu',
      pager                         => 'sdog@inuits.eu',
      password                      => 'wanawer',
      host_notification_commands    => 'notify-host-by-email',
      service_notification_commands => 'notify-service-by-email',
      host_notifications_enabled    => '1',
      service_notifications_enabled => '1',
    }



    Nagios_Hostgroup {
      notify => Service['icinga'],
      target => "${::icinga::targetdir}/hostgroups.cfg",
    }

    nagios_hostgroup{'prod':
      hostgroup_name => 'prod',
    }

    Nagios_host{
      ensure             => present,
      contact_groups     => 'production',
      max_check_attempts => '4',
      check_command      => 'check-host-alive',
      use                => 'linux-server',
      action_url         => '/pnp4nagios/graph?host=$HOSTNAME$',
    }


   # Hmm.. need to put in a full manual host not depending on the 

    # realize Nagios_host['icinga.lan']

    #nagios_host{'icinga':
    #  ensure                => present,
    #  address               => $::icinga::collect_ipaddress,
    #  max_check_attempts    => $::icinga::max_check_attempts,
    #  check_command         => 'check-host-alive',
    #  use                   => 'linux-server',
    #  parents               => $::icinga::parents,
    #  hostgroups            => $::icinga::hostgroups,
    #  action_url            => '/pnp4nagios/graph?host=$HOSTNAME$',
    #  notification_period   => $::icinga::notification_period,
    #  notifications_enabled => $::icinga::notifications_enabled,
    #  icon_image_alt        => $::operatingsystem,
    #  icon_image            => "os/${::operatingsystem}.png",
    #  statusmap_image       => "os/${::operatingsystem}.png",
    #  target                => "${::icinga::targetdir}/hosts/host-${::fqdn}.cfg",
    #}




    icinga::group {'production':
      alias   => 'Production Engineers',
      members => 'sdog',
    }

    file { '/etc/icinga/passwd':
      ensure => 'link',
      group  => '0',
      mode   => '0777',
      owner  => '0',
      target => 'htpasswd.users',
    }





}


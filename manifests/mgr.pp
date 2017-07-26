define ceph::mgr (
  $ensure = running,
  $mgr_enable = true,
) {

  include ::stdlib

  $id = $name

  if $::service_provider == 'upstart' {
    $init = 'upstart'
    Service { "ceph-mgr-${id}":
      provider => $::ceph::params::service_provider,
      start    => "start ceph-mgr id=${id}",
      stop     => "stop ceph-mgr id=${id}",
      status   => "status ceph-mgr id=${id}",
      enable   => $mgr_enable,
      ensure   => $ensure
    }
  } else {
    $init = 'systemd'
    Service { "ceph-mgr@${id}":
      enable => $mgr_enable,
      ensure => $ensure,
    }
  }
}


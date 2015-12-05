# Class: raspberry_dev::scratchbox2
#
#
class raspberry_dev::raspbian_chroot {
  $raspbian_mirror = 'http://archive.raspbian.org/raspbian/'

  $container_init_cmd = "sb2-init -n \
      -c ${raspberry_dev::config::qemu_path} \
      ${raspberry_dev::config::sbox2_container_name} \
      ${raspberry_dev::config::arm_gcc_path}"

  $bootstrap_cmd = 
      "fakeroot debootstrap --verbose --foreign --variant=scratchbox \
        --arch armhf --keyring /etc/apt/trusted.gpg wheezy \
        ${raspberry_dev::config::sbox2_container_path} ${raspbian_mirror}"

  # without this, sbox2 sees HOME as "/root" for some reason, and all sb2 
  # commands fail.
  $sbox2_required_env_flags = ["HOME=/home/vagrant"]

  exec {'scratchbox2-init-container':
    command => $container_init_cmd,
    environment => $sbox2_required_env_flags,
    cwd     => $raspberry_dev::config::sbox2_container_path,
    unless  => "sudo -u vagrant sb2-config -l | grep \"^${raspberry_dev::config::sbox2_container_name}$\"",
    user    => vagrant,
    group   => vagrant,

  } -> exec {'raspbian-install-key':
    command => 'curl http://archive.raspbian.org/raspbian.public.key | apt-key add -',
    unless  => 'apt-key list | grep "Raspberry Pi Debian"'

  } -> exec {'debootstrap-first-stage':
    command => $bootstrap_cmd,
    environment => $sbox2_required_env_flags,
    creates => "${raspberry_dev::config::sbox2_container_path}/var",
    user    => vagrant,
    group   => vagrant,
    timeout => 1500,   # 25 minutes

  } -> exec {'debootstrap-second-stage':
    command => "sb2 -t raspberry -eR ./debootstrap/debootstrap --verbose --second-stage",
    environment => $sbox2_required_env_flags,
    cwd     => $raspberry_dev::config::sbox2_container_path,
    user    => vagrant,
    group   => vagrant,
    onlyif  => "test -f \"${raspberry_dev::config::sbox2_container_path}/debootstrap/debootstrap\"",
    # tries => 2 is set because in my experience, debootstrap fails the first
    # time round, only to succeed on the second. Hmph. The error is:
    #   I: Configuring initramfs-tools...
    #   W: Failure while configuring required packages.
    tries   => 2,
    timeout => 1500,   # 25 minutes

  } -> file {"${raspberry_dev::config::sbox2_container_path}/etc/apt/sources.list":
    source  => "puppet:///modules/raspberry_dev/rootfs/etc/apt/sources.list",
    ensure  => present,
    owner   => vagrant,
    group   => vagrant

  }  -> exec {'sandbox-apt-get-update':
    command => "sb2 -t ${raspberry_dev::config::sbox2_container_name} -eR apt-get update",
    environment => $sbox2_required_env_flags,
    cwd     => $raspberry_dev::config::sbox2_container_path,
    user    => vagrant,
    group   => vagrant,

  } -> exec {'sandbox-install-essentials':
    command => "sb2 -t ${raspberry_dev::config::sbox2_container_name} -eR apt-get install puppet --assume-yes",
    environment => $sbox2_required_env_flags,
    cwd     => $raspberry_dev::config::sbox2_container_path,
    user    => vagrant,
    group   => vagrant,

  } -> file {"${raspberry_dev::config::sbox2_container_path}/etc/puppet/modules/raspbian":
    source   => "puppet:///modules/raspberry_dev/rootfs/etc/puppet/modules/raspbian",
    recurse  => true,
    ensure   => present,
    owner    => vagrant,
    group    => vagrant
    
  } -> exec {'sandbox-provision':
    command => "sb2 -t ${raspberry_dev::config::sbox2_container_name} -eR puppet apply -e \"include raspbian\"",
    environment => $sbox2_required_env_flags,
    cwd     => $raspberry_dev::config::sbox2_container_path,
    user    => vagrant,
    group   => vagrant,
  }
}

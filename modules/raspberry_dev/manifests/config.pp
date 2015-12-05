
class raspberry_dev::config {
  $tools_prefix = '/opt/raspberry-dev'
  $debs_dir = '/opt/raspberry-dev/debs'
  $bin_dir = '/opt/raspberry-dev/bin'

  $user = 'vagrant'
  $sbox2_container_path = '/home/vagrant/raspberry-dev/rootfs'
  $sbox2_container_name = 'raspberry'
  
  $arm_gcc_path = "${bin_dir}/arm-linux-gnueabihf-gcc"
  $qemu_path = "${bin_dir}/qemu-arm"


  file {['/home/vagrant/raspberry-dev',
         '/home/vagrant/raspberry-dev/rootfs']:
    ensure => directory,
    owner  => vagrant,
    group  => vagrant
  }

  file {['/opt/',
         '/opt/raspberry-dev',
         '/opt/raspberry-dev/debs']:
    ensure  => directory,
  }

  file {'/etc/profile.d/raspberry-dev.sh':
    source => 'puppet:///modules/raspberry_dev/etc/profile.d/raspberry-dev.sh',
    mode => '0755'
  }

  user {'vagrant':
    ensure => present,
    home => '/home/vagrant'
  } -> file {'/home/vagrant':
    ensure => directory,
    owner => vagrant,
    group => vagrant
  }

  
  user {'root':
    ensure => present,
    home => '/root'
  } -> file {'/root':
    ensure => directory,
    owner => root,
    group => root
  }
  
  ssh::user {'vagrant':
  }
  
  ssh::user { 'root':
    home => '/root'
  }
}

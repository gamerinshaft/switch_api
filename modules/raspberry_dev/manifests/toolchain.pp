class raspberry_dev::toolchain {
  $toolchain_url = 'http://commondatastorage.googleapis.com/howling-fantods/raspberrypi/raspberry-gcc-toolchain_1.0_i386.deb'
  $toolchain_deb_filename = 'raspberry-gcc-toolchain_1.0_i386.deb'

  exec {'download-toolchain':
    command => "curl -L ${toolchain_url} -o ${toolchain_deb_filename}",
    cwd => $raspberry_dev::config::debs_dir,
    creates => "${raspberry_dev::config::debs_dir}/${toolchain_deb_filename}"

  } -> package {'raspberry-gcc-toolchain': 
    provider => dpkg, 
    ensure => installed, 
    source => "${raspberry_dev::config::debs_dir}/${toolchain_deb_filename}"
  } 
}
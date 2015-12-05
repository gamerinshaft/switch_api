class raspberry_dev::qemu {
  $qemu_url = 'http://commondatastorage.googleapis.com/howling-fantods/raspberrypi/raspberry-qemu_1.3.0_amd64.deb'
  $qemu_deb_filename = 'raspberry-qemu_1.3.0_amd64.deb'

  exec {'download-qemu':
    command => "curl -L ${qemu_url} -o ${qemu_deb_filename}",
    cwd => $raspberry_dev::config::debs_dir,
    creates => "${raspberry_dev::config::debs_dir}/${qemu_deb_filename}"

  } -> package {'raspberry-qemu':
    provider => dpkg, 
    source => "${raspberry_dev::config::debs_dir}/${qemu_deb_filename}",
    ensure => installed
  }
}
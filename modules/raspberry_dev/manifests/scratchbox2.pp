class raspberry_dev::scratchbox2 {
  $sbox2_url = 'http://commondatastorage.googleapis.com/howling-fantods/raspberrypi/raspberry-scratchbox2_2.3.90_amd64.deb'
  $sbox2_deb_filename = 'raspberry-scratchbox2_2.3.90_amd64.deb'

  exec {'download-sbox2':
    command => "curl -L ${sbox2_url} -o ${sbox2_deb_filename}",
    cwd     => $raspberry_dev::config::debs_dir,
    creates => "${raspberry_dev::config::debs_dir}/${sbox2_deb_filename}"

  } -> package {'raspberry-scratchbox2':
    provider => dpkg, 
    source  => "${raspberry_dev::config::debs_dir}/${sbox2_deb_filename}",
    ensure  => installed

  } 
}
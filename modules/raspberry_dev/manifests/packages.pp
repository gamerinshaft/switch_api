class raspberry_dev::packages {
  $required_packages = ['libncurses5', 'fakeroot', 'debootstrap', 'curl',
    'libstdc++6:i386', 'zlib1g:i386', 'libc6-dev-i386', 'build-essential']

  package {$required_packages:
    ensure  => installed,
    require => Exec['apt-get update']
  }
}

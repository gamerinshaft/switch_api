 class raspbian {

  package {['locales', 'dialog']:
    ensure  => installed
  }

  package {['pkg-config', 'libglib2.0-dev']:
    ensure  => installed
  }
}

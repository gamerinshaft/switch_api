# - This is cobbled together from various sources, including:
#    - <http://manpages.ubuntu.com/manpages/lucid/man8/debootstrap.8.html>
#    - <http://jecxjo.motd.org/code/blosxom.cgi/devel/cross_compiler_environment>
#    - <http://npascut1.wordpress.com/2012/01/10/bridging-the-gap-cross-compilation-for-arm/>
#    - <http://russelldavis.org/2011/09/07/setting-up-scratchbox2-from-scratch-for-the-raspberry-pi/>
#    - <http://www.daimi.au.dk/~cvm/sb2.pdf> (This is an decent introduction to ScratchBox2)

class raspberry_dev {
  Exec { path => ['/usr/local/bin/', '/bin/', '/sbin/', '/usr/bin/', 
                  '/usr/sbin/', '/opt/vagrant_ruby/bin',
                  '/opt/raspberry-dev/bin'],
         timeout => 600 
  }

  include sysconfig
  include sysconfig::sudoers
  include ssh::server
  include apt 
  
  include raspberry_dev::packages
  include raspberry_dev::config
  include raspberry_dev::toolchain
  include raspberry_dev::qemu
  include raspberry_dev::scratchbox2
  include raspberry_dev::raspbian_chroot
}
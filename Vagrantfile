Vagrant.configure("2") do |config|
  config.vm.box = "centos.for.Switch"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/" +
    "releases/download/v6.5.3/centos65-x86_64-20140116.box"
  config.vm.provider :virtualbox do |vb|
    vb.customize [ 'modifyvm', :id, '--memory', 1024 ]
  end
  config.vm.network "forwarded_port", guest: 3000, host: 4000

  config.vm.provision :shell, inline: "yum -y update"
  config.vm.provision :shell, inline: "yum -y install wget"
  config.vm.provision :shell, inline: "yum -y install tmux"
  config.vm.provision :shell, inline: "yum -y install graphviz"

  config.vm.provision :shell, path: "provision/chruby.sh"
  config.vm.provision :shell, path: "provision/ruby-install.sh"
  config.vm.provision :shell, path: "provision/ruby.sh"
  config.vm.provision :shell, path: "provision/rails.sh", privileged: false
  config.vm.provision :shell, path: "provision/foreman.sh", privileged: false
  config.vm.provision :shell, path: "provision/mysql-server.sh"
  # config.vm.provision :shell, path: "provision/postgresql-server.sh"
  config.vm.provision :shell, path: "provision/redis.sh"
  config.vm.provision :shell, path: "provision/limits.sh"
end

# -*- mode: ruby -*-

Vagrant.configure("2") do |config|
  config.vm.hostname = "ontoden.local"
  config.vm.network "private_network", ip: "172.16.100.2"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "site.yml"
    ansible.host_key_checking = false
    ansible.extra_vars = { ansible_ssh_user: "vagrant", testing: true }
  end

  # vagrant-cachier
  # More information: https://github.com/fgrehm/vagrant-cachier
  if Vagrant.has_plugin? "vagrant-cachier"
    config.cache.enable :apt
    config.cache.scope = :box
  end

  config.vm.define "debian", primary: true do |debian|
    debian.vm.box = "box-cutter/debian76"
  end
end

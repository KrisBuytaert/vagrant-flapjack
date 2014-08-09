Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :flapjack do |flapjack_config|
       flapjack_config.ssh.max_tries = 100
       flapjack_config.vm.box = "Centos65"
       flapjack_config.vm.network :hostonly, "192.168.99.103"
       flapjack_config.vm.host_name = "flapjack"
       flapjack_config.vm.provision :puppet do |flapjack_puppet|
        flapjack_puppet.manifests_path = "manifests"
        flapjack_puppet.module_path = "modules"
        flapjack_puppet.manifest_file = "site.pp"
       end
   end  
  config.vm.define :icinga do |icinga_config|
       icinga_config.ssh.max_tries = 100
       icinga_config.vm.box = "Centos65"
       icinga_config.vm.network :hostonly, "192.168.99.104"
       icinga_config.vm.host_name = "icinga"
       icinga_config.vm.provision :puppet do |icinga_puppet|
        icinga_puppet.manifests_path = "manifests"
        icinga_puppet.module_path = "modules"
        icinga_puppet.manifest_file = "site.pp"
       end
   end  
end

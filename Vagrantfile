# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.ssh.forward_agent = true

  config.vm.provider :vmware_fusion do |f, override|
    override.vm.box_url = "http://files.vagrantup.com/precise64_vmware_fusion.box"
    f.vmx["displayName"] = "passenger-docker"
    # VMWare Tools is rendered unusable by the kernel upgrade,
    # and there's no easy way to automatically reinstall it,
    # so we use NFS instead of VMWare Shared Folders.
    config.vm.synced_folder ".", "/vagrant", :nfs => true
  end

  # Provision docker and new kernel if deployment was not done.
  # It is assumed Vagrant can successfully launch the provider instance.
  if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
    # Add lxc-docker package
    pkg_cmd = "wget -q -O - https://get.docker.io/gpg | apt-key add -;" \
      "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list;" \
      "apt-get update -qq; apt-get install -q -y --force-yes lxc-docker; "
    # Add Ubuntu raring backported kernel
    pkg_cmd << "apt-get update -qq; apt-get install -q -y linux-image-generic-lts-raring; "
    # Add guest additions if local vbox VM. As virtualbox is the default provider,
    # it is assumed it won't be explicitly stated.
    if ENV["VAGRANT_DEFAULT_PROVIDER"].nil? && ARGV.none? { |arg| arg.downcase.start_with?("--provider") }
      pkg_cmd << "apt-get install -q -y linux-headers-generic-lts-raring dkms; " \
        "echo 'Downloading VBox Guest Additions...'; " \
        "wget -q http://dlc.sun.com.edgesuite.net/virtualbox/4.2.12/VBoxGuestAdditions_4.2.12.iso; "
      # Prepare the VM to add guest additions after reboot
      pkg_cmd << "echo -e 'mount -o loop,ro /home/vagrant/VBoxGuestAdditions_4.2.12.iso /mnt\n" \
        "echo yes | /mnt/VBoxLinuxAdditions.run\numount /mnt\n" \
          "rm /root/guest_additions.sh; ' > /root/guest_additions.sh; " \
        "chmod 700 /root/guest_additions.sh; " \
        "sed -i -E 's#^exit 0#[ -x /root/guest_additions.sh ] \\&\\& /root/guest_additions.sh#' /etc/rc.local; " \
        "echo 'Installation of VBox Guest Additions is proceeding in the background.'; " \
        "echo '\"vagrant reload\" can be used in about 2 minutes to activate the new guest additions.'; "
    end
    # Add vagrant user to the docker group
    pkg_cmd << "usermod -a -G docker vagrant; "
    # Activate new kernel
    pkg_cmd << "shutdown -r +1; "
    pkg_cmd << "echo ---------- Kernel upgraded and Docker installed ----------; "
    pkg_cmd << "echo 'Please run \"vagrant reload\" in about 2 minutes to activate the new kernel and Docker.'"
    config.vm.provision :shell, :inline => pkg_cmd
  end
end

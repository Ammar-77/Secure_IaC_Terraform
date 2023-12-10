

data "vsphere_network" "APPs_LAN" {
  name          = "APPs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "APP_Template" {
  name          = "AppServer01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


// ................VMs creation .....................



resource "vsphere_virtual_machine" "Test_APP_Server" {
    name             = "Test_APP_Server"
    num_cpus         = 2
    memory           = 1024
    guest_id         =  "centos64Guest"  /// for CentOS
    resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
    host_system_id   = "${data.vsphere_host.esxi_host.id}"  # Replace with your ESXi host ID
    datastore_id     = data.vsphere_datastore.datastore.id

   disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
 
   network_interface {
    network_id = data.vsphere_network.APPs_LAN.id
    adapter_type  =  data.vsphere_virtual_machine.APP_Template.network_interface_types[0]
       
  }
  clone {
        template_uuid = data.vsphere_virtual_machine.APP_Template.id

  }

provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname Test_APP_Server" ,
      "sudo systemctl restart systemd-hostnamed"
    ]

    connection {
       type     = "ssh"
       host     = self.default_ip_address
       user     = "root"
       password = "hardtoguess1"  # Note: It's more secure to use SSH keys
    }
  }

  }




data "vsphere_network" "APPs_LAN" {
  name          = "APPs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "APP_Template" {
  name          = "APP_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "LD_Template" {
  name          = "LD_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
// ................VMs creation .....................


resource "vsphere_virtual_machine" "APP_LoadBalancer01" {
    name             = "APP_LoadBalancer01"
    num_cpus         = 2
    memory           = 1024
    guest_id         = "other3xLinux64Guest"  /// for Ubuntu Server 
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
       adapter_type = data.vsphere_virtual_machine.LD_Template.network_interface_types[0]

  }
  clone {
        template_uuid = data.vsphere_virtual_machine.LD_Template.id
     customize {
      linux_options {
        host_name = "appld01"
        domain=""
      }
       network_interface { }
     }
  }

  }



resource "vsphere_virtual_machine" "APP_Server02" {
    name             = "APP_Server02"
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
   /* customize {
      linux_options {
        host_name = "appserver02"
       domain=""
      }

      network_interface {
        ipv4_address = "120.20.10.244"
        ipv4_netmask = 24
      }
      ipv4_gateway = "120.20.10.1"
     }*/
  }

provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname app-server02" ,
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


resource "vsphere_virtual_machine" "APP_Server03" {
    name             = "APP_Server03"
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
   adapter_type = data.vsphere_virtual_machine.APP_Template.network_interface_types[0]

  }

  clone {
        template_uuid = data.vsphere_virtual_machine.APP_Template.id
   }

 provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname app-server03" ,
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

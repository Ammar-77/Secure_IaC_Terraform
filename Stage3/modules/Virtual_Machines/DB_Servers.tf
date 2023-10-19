

data "vsphere_network" "DBs_LAN" {
  name          = "DBs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_virtual_machine" "DB_Template" {
  name          = "DB_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


resource "vsphere_virtual_machine" "DBServer02" {
    name             = "DBServer02"
    num_cpus            = 2
    memory           = 2048
    guest_id = "centos7_64Guest"  /// for CentOS
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
    network_id = data.vsphere_network.DBs_LAN.id
    adapter_type = data.vsphere_virtual_machine.DB_Template.network_interface_types[0]

  }

  clone {
        template_uuid = data.vsphere_virtual_machine.DB_Template.id
     customize {
      linux_options {
        host_name = "db-server02"
        domain=""
      }
       network_interface { }
     }
  }
}




resource "vsphere_virtual_machine" "DBServer03" {
   name             = "DBServer03"
   num_cpus            = 2
   memory           = 2048
   guest_id = "centos7_64Guest"  /// for CentOS

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
    network_id = data.vsphere_network.DBs_LAN.id
       adapter_type = data.vsphere_virtual_machine.DB_Template.network_interface_types[0]

  }

  clone {
        template_uuid = data.vsphere_virtual_machine.DB_Template.id
     customize {
      linux_options {
        host_name = "db-server03"
        domain=""
      }
       network_interface { }
     }
  }
  }

  /*
 provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname DBServer03" ,
      "sudo systemctl restart systemd-hostnamed"
    ]

    connection {
      type     = "ssh"
      host     = self.default_ip_address
       user     = "root"
      password = "hardtoguess1"  # Note: It's more secure to use SSH keys
    }
  }
  */






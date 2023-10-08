
data "vsphere_network" "Backend_LAN" {
  name          = "Backend_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "Web_LAN" {
  name          = "Web_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "Shadow_LAN" {
  name          = "Shadow_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "DBs_LAN" {
  name          = "DBs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "APPs_LAN" {
  name          = "APPs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "ISPs_LAN" {
  name          = "ISPs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "DevOps_LAN" {
  name          = "DevOps_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
} 
/* the DevOps server should be on it after it is intlizaied with all the 
softtwares that it need , the mangment LAN is essential for building the enviroemnt 
*/

/*data "vsphere_network" "VM_Network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}  */ //// replaced by the mnangement lan 


resource "vsphere_virtual_machine" "Gateway_Server" {
  name             = "Backend_Gateway_Server"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
 
  network_interface {
    network_id = data.vsphere_network.Backend_LAN.id
 
  }
  network_interface {
    network_id = data.vsphere_network.DBs_LAN.id
  }
  network_interface {
    network_id = data.vsphere_network.APPs_LAN.id
  }
  network_interface {
    network_id = data.vsphere_network.Web_LAN.id
  }
  network_interface {
    network_id = data.vsphere_network.Shadow_LAN.id
  }
  
 /* network_interface {
    network_id = data.vsphere_network.ISPs_LAN.id
  }
*/
  network_interface {
    network_id = data.vsphere_network.DevOps_LAN.id
  } 


 disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
 cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/ubuntu-22.04.3-live-server-amd64.iso"
  }
  
}

resource "vsphere_virtual_machine" "DHCP_Server" {
  name             = "DHCP_Server"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.Backend_LAN.id
  }
 disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
  cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/ubuntu-23.04-desktop-amd64.iso"
  }
}
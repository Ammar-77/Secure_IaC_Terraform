
data "vsphere_network" "network05" {
  name          = "Backend_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "network03" {
  name          = "Web_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "network04" {
  name          = "Shadow_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_network" "network01" {
  name          = "DB_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network02" {
  name          = "App_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "network0011" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}


resource "vsphere_virtual_machine" "Internal_Gateway_Server" {
  name             = "Internal_Gateway_Server"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network05.id
  }
  network_interface {
    network_id = data.vsphere_network.network01.id
  }
  network_interface {
    network_id = data.vsphere_network.network02.id
  }
  network_interface {
    network_id = data.vsphere_network.network03.id
  }
  network_interface {
    network_id = data.vsphere_network.network04.id
  }

  network_interface {
    network_id = data.vsphere_network.network0011.id
  } // to connect to the DevOps server ....... 

network_interface {
    network_id = data.vsphere_network.network06.id
  } // to connect to the ISP server lan ....... 


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

resource "vsphere_virtual_machine" "DHCP_Server" {
  name             = "DHCP_Server"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network05.id
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
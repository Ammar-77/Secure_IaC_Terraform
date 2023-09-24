/*// Creating VLan1 
resource "vsphere_host_port_group" "port-group01" {
  name = "VLAN01"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 1
}*/


// ................VMs creation .....................

data "vsphere_network" "network01" {
  name          = "DB_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_virtual_machine" "DB_Server01" {
  name             = "DB_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
 guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network01.id
  }
  disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
   cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/CentOS-7-x86_64-DVD-2207-02.iso"
  }

}

resource "vsphere_virtual_machine" "DB_Server02" {
  name             = "DB_Server02"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network01.id
  }
 disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
   cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/CentOS-7-x86_64-DVD-2207-02.iso"
  }
}

resource "vsphere_virtual_machine" "DB_Firewall01" {
  name             = "DB_Firewall01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network01.id
  }
disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
   cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/CentOS-7-x86_64-DVD-2207-02.iso"
  }
}

resource "vsphere_virtual_machine" "DB_Load_Balancer01" {
  name             = "DB_Load_Balancer01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network01.id
  }
 disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
   cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/CentOS-7-x86_64-DVD-2207-02.iso"
  }
}


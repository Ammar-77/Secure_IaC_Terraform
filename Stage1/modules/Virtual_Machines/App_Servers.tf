/*
resource "vsphere_host_port_group" "port-group02" {
  name = "VLAN02"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 2
}
*/
 
data "vsphere_network" "network02" {
  name          = "App_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}


// ................VMs creation .....................

resource "vsphere_virtual_machine" "App_Server01" {
  name             = "App_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network02.id
  }

 disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
  /* cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/ubuntu-22.04.3-live-server-amd64.iso"
  }*/
}

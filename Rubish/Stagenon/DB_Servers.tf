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


data "vsphere_virtual_machine" "source_vm" {
  name          = "DB_Server01"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_virtual_machine" "new_vm" {
  name             = "DB_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  clone {
    template_uuid = data.vsphere_virtual_machine.source_vm.id
  }
  disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1

  network_interface {
    network_id   = data.vsphere_network.network01.id
   // adapter_type = "vmxnet3"  # Use the appropriate adapter type
  }
}

/*
resource "vsphere_virtual_machine" "DB_Server01" {
  name             = "DB_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 4096
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
  /* cdrom {
   
    datastore_id  = data.vsphere_datastore.datastore.id
    path          = "./myISOfiles/ubuntu-22.04.3-live-server-amd64.iso"
  }*/





data "vsphere_network" "APPs_LAN" {
  name          = "APPs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
// ................VMs creation .....................
/*
resource "vsphere_virtual_machine" "App_Server01" {
  name             = "App_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.APPs_LAN.id
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
*/
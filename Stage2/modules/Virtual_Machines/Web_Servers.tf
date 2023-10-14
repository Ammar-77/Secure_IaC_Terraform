
data "vsphere_network" "Web_LAN" {
  name          = "Web_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

// ................VMs creation .....................

resource "vsphere_virtual_machine" "Web_Server01" {
  name             = "Web_Server01"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
    guest_id         = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.Web_LAN.id
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
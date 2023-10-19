

/*data "vsphere_network" "network03" {
  name          = "Web_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}*/ ///// it is inherted from the Gateway_Server.tf

resource "vsphere_virtual_machine" "ISP" {
  name             = "ISP - Internet Provider"
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2048
  guest_id         = "other3xLinux64Guest"


  network_interface {
    network_id = data.vsphere_network.ISPs_LAN.id
  }
  network_interface {
    network_id = data.vsphere_network.Web_LAN.id
  }
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
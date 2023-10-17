
data "vsphere_network" "DBs_LAN" {
  name          = "DBs_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "DBServer01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "DB_template" {
  name             = "DB_template"
  num_cpus         = 2
  memory           = 2048
  guest_id = "centos7_64Guest"  # Replace with your guest OS ID
  // datacenter_id    = data.vsphere_datacenter.datacenter.id
  resource_pool_id = data.vsphere_host.esxi_host.resource_pool_id
  host_system_id   = "${data.vsphere_host.esxi_host.id}"  # Replace with your ESXi host ID
  datastore_id     = data.vsphere_datastore.datastore.id

  network_interface {
       network_id = data.vsphere_network.DBs_LAN.id
  }
  
  clone {
    template_uuid = "50117578-7289-9eb1-f94a-e866d093425a"
    /*     customize {
      linux_options {
        host_name = "DB_Template"
        domain=""
      }
     }*/
  }
     disk {
    label = "disk0"
    size  = 60
  }
  scsi_type = "lsilogic-sas"
  sata_controller_count = 1
}
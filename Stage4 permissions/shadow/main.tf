provider "vsphere" {
  user           = var.Shaddow_vCenter_user
  password       = var.Shaddow_vCenter_password
  vsphere_server = var.vCenter_server
  allow_unverified_ssl = true
}
 
data "vsphere_datacenter" "datacenter" {
  name = "Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "server137-ds1"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_host" "esxi_host" {
  name          = var.vsphere_server
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_network" "Shadow_LAN" {
  name          = "Shadow_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}



data "vsphere_virtual_machine" "shadow_Template" {
  name          = "AppServer01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
/*
data "vsphere_virtual_machine" "LD_Template" {
  name          = "LD_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}*/
// ................VMs creation .....................


resource "vsphere_virtual_machine" "APPServer_Shadow" {
    name             = "APPServerShadow"
    num_cpus         = 2
    memory           = 1024
    guest_id         = "centos64Guest"  /// for Ubuntu Server 
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
    network_id = data.vsphere_network.Shadow_LAN.id
   // adapter_type = data.vsphere_virtual_machine.shadow_Template.network_interface_types[0]

  }
  clone {
        template_uuid = data.vsphere_virtual_machine.shadow_Template.id
    customize {
      linux_options {
        host_name = "AppServerShadow"
        domain=""
      }
      
     }
  }

  }



/*
module "Virtual_Networks" {
  source = "./modules/Virtual_Machines"
}
*/

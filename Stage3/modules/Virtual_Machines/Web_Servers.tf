
/* 
data "vsphere_network" "Web_LAN" {
  name          = "Web_LAN"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

data "vsphere_virtual_machine" "Web_Template" {
  name          = "Web_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "LD_Template" {
  name          = "LD_Template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

// ................VMs creation .....................

resource "vsphere_virtual_machine" "Web_LoadBalancer01" {
    name             = "Web_LoadBalancer01"
    num_cpus         = 2
    memory           = 1024
    guest_id         = "other3xLinux64Guest"  /// for UBuntu Server 
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
    network_id = data.vsphere_network.Web_LAN.id
   adapter_type = data.vsphere_virtual_machine.LD_Template.network_interface_types[0]

  }
  clone {
        template_uuid = data.vsphere_virtual_machine.LD_Template.id
     customize {
      linux_options {
        host_name = "webld01"
        domain=""
      }
       network_interface { }
     }
  }
}

resource "vsphere_virtual_machine" "Web_Server02" {
   name             = "Web_Server02"
   num_cpus            = 2
   memory           = 1024
   guest_id =  "other3xLinux64Guest"  // for UBuntu Server 

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
    network_id = data.vsphere_network.Web_LAN.id
       adapter_type = data.vsphere_virtual_machine.Web_Template.network_interface_types[0]

  }

 clone {
        template_uuid = data.vsphere_virtual_machine.Web_Template.id
     customize {
      linux_options {
        host_name = "weberver02"
        domain=""
                    }
            network_interface { }
           }
   }
  }


resource "vsphere_virtual_machine" "Web_Server03" {
   name             = "Web_Server03"
   num_cpus            = 2
   memory           = 1024
   guest_id =  "other3xLinux64Guest"  /// for UBuntu Server 

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
    network_id = data.vsphere_network.Web_LAN.id
    adapter_type = data.vsphere_virtual_machine.Web_Template.network_interface_types[0]

   }


  clone {
        template_uuid = data.vsphere_virtual_machine.Web_Template.id
     customize {
      linux_options {
        host_name = "weberver03"
        domain=""
      }
            network_interface { }
    }

  }
  }

*/
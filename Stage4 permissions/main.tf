provider "vsphere" {
  user           = var.vCenter_user
  password       = var.vCenter_password
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

data "vsphere_role" "admin2r" {
    label = "Administrator"
}

data "vsphere_role" "admin2_VM_R1" {
    label = "Virtual Machine console user"
}





resource "vsphere_entity_permissions" "datacenter_access" {

  entity_id = data.vsphere_datacenter.datacenter.id
  entity_type = "Datacenter"
  permissions {
    user_or_group = "letterkenny.ads.kmn.ie\\admin2"
    propagate = true
   is_group = false
   role_id = data.vsphere_role.admin2r.id    
  }
}

resource "vsphere_entity_permissions" "datastore_access" {

  entity_id = data.vsphere_datastore.datastore.id
  entity_type = "Datastore"
  permissions {
    user_or_group = "letterkenny.ads.kmn.ie\\admin2"
    propagate = true
   is_group = false
   role_id = data.vsphere_role.admin2r.id    
  }
}

resource "vsphere_entity_permissions" "shadow_network_access" {

  entity_id = data.vsphere_network.Shadow_LAN.id 
  entity_type = "Network"
  permissions {
    user_or_group = "letterkenny.ads.kmn.ie\\admin2"
    propagate = true
   is_group = false
   role_id = data.vsphere_role.admin2r.id    
  }
}

data "vsphere_virtual_machine" "shadow_Template" {
  name          = "AppServer01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_entity_permissions" "admin2_vm_clone_permission" {
  entity_id   = data.vsphere_virtual_machine.shadow_Template.id  # The VM you want to clone from
  entity_type = "VirtualMachine"
 /* permissions {
    
  user_or_group = "letterkenny.ads.kmn.ie\\admin2"  # Replace with the actual username or group
  propagate = true  # Set to false if you only want to grant permissions to the specified VM
  is_group = false
  role_id = data.vsphere_role.admin2_VM_R1.id    # This role allows interaction with virtual machines, including cloning
}
*/
permissions {
    
  user_or_group = "letterkenny.ads.kmn.ie\\admin2"  # Replace with the actual username or group
  propagate = true  # Set to false if you only want to grant permissions to the specified VM
  is_group = false
  role_id = data.vsphere_role.admin2r.id   # This role allows interaction with virtual machines, including cloning
}

}


/*
module "Virtual_Networks" {
  source = "./modules/Virtual_Machines"
}
*/

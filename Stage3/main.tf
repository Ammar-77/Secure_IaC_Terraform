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






module "Virtual_Networks" {
  source = "./modules/Virtual_Machines"
}


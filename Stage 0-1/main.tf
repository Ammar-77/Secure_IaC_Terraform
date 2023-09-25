provider "vsphere" {
  user                 = var.user_root
  password             = var.password_root
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

 
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_host_name
}

data "vsphere_datastore" "datastore" {
  name          = "server137-ds1"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}
data "vsphere_host" "esxi_host" {
  name          = var.vsphere_host_name
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

module "Virtual_Networks" {
  source = "./modules/Virtual_Machines"
}





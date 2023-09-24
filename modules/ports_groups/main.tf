
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_host_name
}

data "vsphere_host" "esxi_host" {
  name          = var.vsphere_host_name
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

// Creating VLan1 
resource "vsphere_host_port_group" "port-group01" {
  name = "DB_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 1
}

// Creating VLan2
resource "vsphere_host_port_group" "port-group02" {
  name = "App_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 2
}
// Creating VLan3
resource "vsphere_host_port_group" "port-group03" {
  name = "Web_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 3
}

//// Creating VLan4

resource "vsphere_host_port_group" "port-group04" {
  name = "Shadow_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 4
}


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




///  resource creating 


// Creating DB_LAN
resource "vsphere_host_port_group" "port-group01" {
  name = "DBs_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 1
}

// Creating App_LAN
resource "vsphere_host_port_group" "port-group02" {
  name = "APPs_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 2
}
// Creating Web_LAN
resource "vsphere_host_port_group" "port-group03" {
  name = "Web_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 3
}

//// Creating Shadow_LAN

resource "vsphere_host_port_group" "port-group04" {
  name = "Shadow_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 4
}

// Creating ISPs_LAN
resource "vsphere_host_port_group" "port-group05" {
  name = "ISPs_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 0
} 


//// Inner_LAN
resource "vsphere_host_port_group" "port-group06" {
  name = "Backend_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 5
}

//// Inner_LAN/*
/*resource "vsphere_host_port_group" "port-group07" {
  name = "DevOps_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 7
}*/
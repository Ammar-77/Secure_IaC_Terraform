

resource "vsphere_host_port_group" "port-group05" {
  name = "Internet_Facing_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 0
} 

// Creating DB_LAN
resource "vsphere_host_port_group" "port-group01" {
  name = "DB_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 1
}

// Creating App_LAN
resource "vsphere_host_port_group" "port-group02" {
  name = "App_LAN"
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


//// Internal_Facing_LAN
resource "vsphere_host_port_group" "port-group06" {
  name = "Internal_Facing_LAN"
  host_system_id = data.vsphere_host.esxi_host.id
  virtual_switch_name = "vSwitch0"
  vlan_id = 5
}
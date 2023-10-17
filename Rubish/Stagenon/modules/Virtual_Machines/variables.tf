//// Admin user Credentials /////
variable "user_root" {
  description = "The root user of the EXSi"
  default     = "Ammar"
}
variable "password_root" {
  description = "The root user password"
  default     = "Cli3nt:F1tbit"
}

////// EXSi host IP
variable "vsphere_server" {
  description = "EXSi host IP"
  default     = "172.28.2.137"
}


variable "vsphere_host_name" {
  default     = "server137.letterkenny.ads.kmn.ie"
}
/*
import {
  to = data.vsphere_host.esxi_host.Vswitch
  id = "i-abcd1234"
}*/
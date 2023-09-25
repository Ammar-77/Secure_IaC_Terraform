//// Admin user Credentials /////
variable "user_root" {
  description = "The root user of the EXSi"
  default     = "Ammar"
}
variable "password_root" {
  description = "The root user password"
  default     = "Cli3nt:F1tbit"
}



//// Shaddow IT Credentials ////
variable "Shaddow_IT_user_root" {
  description = "The IT shadow user of the EXSi"
  default     = "shadow-IT"
}
variable "Shaddow_IT_password_root" {
  description = "The IT shadow user password"
  default     = "Ammar@1990"
}

//// Shaddow Admin Credentials ////
variable "Shaddow_user_root" {
  description = " Shaddow Admin of the EXSi"
  default     = "admin2"
}
variable "Shaddow_password_root" {
  description = " Shaddow Admin password"
  default     = "Ammar@1990"
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
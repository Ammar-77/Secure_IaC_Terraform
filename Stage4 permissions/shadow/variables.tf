//// Admin user Credentials /////
variable "vCenter_user" {
  description = "The root user of the vCenter"
  default     = "administrator@letterkenny.ads.kmn.ie"
}
variable "vCenter_password" {
  description = "The administrator user password"
  default     = "Seba@1990"
}



//// Shaddow IT Credentials ////
variable "Shaddow_vCenter_user" {
  description = "The IT shadow user of the EXSi"
  default     = "admin2@letterkenny.ads.kmn.ie"
}
variable "Shaddow_vCenter_password" {
  description = "The IT shadow user password"
  default     = "Seba@1990"
}


////// EXSi host IP
variable "vsphere_server" {
  description = "EXSi host IP"
  default     = "172.28.2.137"
}
variable "vCenter_server" {
  description = "EXSi host IP"
  default     = "172.28.1.46"
}

variable "vsphere_host_name" {
  default     = "server137.letterkenny.ads.kmn.ie"
}

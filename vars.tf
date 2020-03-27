variable "client_id" {
  type    = string
  default = ""
}
variable "subscription_id" {
  type    = string
  default = ""
}
variable "tenant_id" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = "West US"
}
variable "cluster_name" {
  type    = "string"
  default = "fortigate-secure-remote-access"
}
variable "admin_name" {
  type    = "string"
  default = "masteradmin"
}
variable "admin_password" {
  type    = "string"
  default = "Temp1234!"
}
variable "psk_key" {
  type    = "string"
  default = "123456789"
}
# Subnet of the office or home network spoke
variable "remote_subnet" {
  type    = "string"
  default = "10.100.81.0"
}
variable "remote_subnet_netmask" {
  type    = "string"
  default = "255.255.255.0"
}
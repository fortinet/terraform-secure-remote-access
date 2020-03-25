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
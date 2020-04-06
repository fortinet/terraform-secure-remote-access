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
# Start and End IP of the tunnel. This will determine how many users can connect.
variable "ssl_tunnel_start_ip" {
  type    = "string"
  default = "10.212.134.200"
}
variable "ssl_tunnel_end_ip" {
  type    = "string"
  default = "10.212.134.210"
}
variable "set_bgp_remote_as" {
  type = "string"
  default = "65400"
}
# Set the BGP route for the tunnel network.
variable "ssl_tunnel_bgp_network_prefix" {
  type    = "string"
  default = "10.212.134.0"
}
variable "ssl_tunnel_bgp_network_netmask" {
  type    = "string"
  default = "255.255.255.0"
}

#Hub Tunnel Interface IP
variable "hub_tunnel_ip" {
  type = "string"
  default = "10.10.1.1"
}
variable "hub_tunnel_netmask" {
  type = "string"
  default = "255.255.255.255"
}

#Spoke tunnel IP
variable "spoke_tunnel_ip" {
  type = "string"
  default = "10.10.1.3"
}
variable "spoke_tunnel_netmask" {
  type = "string"
  default = "255.255.255.0"
}


variable "client_id" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
 variable "region" {
   type = string
 }
 variable "cluster_name" {
   type = string
 }
 variable "admin_name" {
   type = string
 }
variable "admin_password" {
  type = string
}
variable "psk_key" {
  type = string
}
# Subnet of the office or home network spoke
variable "remote_subnet" {
  type = string
}
variable "remote_subnet_netmask" {
  type = string
}
# Start and End IP of the tunnel. This will determine how many users can connect.
variable "ssl_tunnel_start_ip" {
  type = string
}
variable "ssl_tunnel_end_ip" {
  type = string
}
variable "set_bgp_remote_as" {
  type = string
}
# Set the BGP route for the tunnel network.
variable "ssl_tunnel_bgp_network_prefix" {
  type = string
}
variable "ssl_tunnel_bgp_network_netmask" {
  type = string
}

#Hub Tunnel Interface IP
variable "hub_tunnel_ip" {
  type = string
}
variable "hub_tunnel_netmask" {
  type = string
}

#Spoke tunnel IP
variable "spoke_tunnel_ip" {
  type = string
}
variable "spoke_tunnel_netmask" {
  type = string
}

variable "external_address_space" {
  type = list(string)
}

variable "internal_address_prefix" {
  type = string
}

variable "hub_vm_size" {
  type = string
}

variable "fgt_sku" {
  type = string
}

variable "fgt_product" {
  type = string
}

variable "fgt_version" {
  type = string
}

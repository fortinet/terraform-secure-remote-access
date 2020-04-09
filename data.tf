
data "template_file" "setupFortiGate" {
  template = "${file("${path.module}/configscripts/fortigateconfig")}"
  vars = {
    psk_key                        = var.psk_key == "" ? random_string.random_psk_key.result : var.psk_key,
    remote_subnet                  = "${var.remote_subnet}"
    remote_subnet_netmask          = "${var.remote_subnet_netmask}"
    ssl_tunnel_start_ip            = "${var.ssl_tunnel_start_ip}"
    ssl_tunnel_end_ip              = "${var.ssl_tunnel_end_ip}"
    ssl_tunnel_bgp_network_prefix  = "${var.ssl_tunnel_bgp_network_prefix}"
    ssl_tunnel_bgp_network_netmask = "${var.ssl_tunnel_bgp_network_netmask}"
    set_bgp_remote_as              = "${var.set_bgp_remote_as}"
    hub_tunnel_ip                  = "${var.hub_tunnel_ip}"
    hub_tunnel_netmask             = "${var.hub_tunnel_netmask}"
    spoke_tunnel_ip                = "${var.spoke_tunnel_ip}"
  }
}

data "template_file" "easy_key_setup" {
  template = "${file("${path.module}/configscripts/easy_key_setup")}"
  vars = {
    hubGatewayIp   = "${azurerm_public_ip.public_ip.ip_address}",
    hub_tunnel_ip  = "${var.hub_tunnel_ip}"
    hubIndentifier = "${var.set_bgp_remote_as}"
    indentifier    = "${var.set_bgp_remote_as}"
    tunnelIp       = "${var.spoke_tunnel_ip}"
  }
}
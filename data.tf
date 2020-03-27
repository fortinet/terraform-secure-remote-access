
data "template_file" "setupFortiGate" {
  template = "${file("${path.module}/configscripts/fortigateconfig")}"
  vars = {
    psk_key     = "${var.psk_key}",
    remote_subnet = "${var.remote_subnet}"
    remote_subnet_netmask = "${var.remote_subnet_netmask}"
    ssl_tunnel_start_ip = "${var.ssl_tunnel_start_ip}"
    ssl_tunnel_end_ip = "${var.ssl_tunnel_end_ip}"
    ssl_tunnel_bgp_network_prefix = "${var.ssl_tunnel_bgp_network_prefix}"
    ssl_tunnel_bgp_network_netmask = "${var.ssl_tunnel_bgp_network_netmask}"
    set_bgp_remote_as = "${var.set_bgp_remote_as}"
  }
}
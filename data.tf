
data "template_file" "setupFortiGate" {
  template = "${file("${path.module}/configscripts/fortigateconfig")}"
  vars = {
    psk_key     = "${var.psk_key}",
    remote_subnet = "${var.remote_subnet}"
    remote_subnet_netmask = "${var.remote_subnet_netmask}"
    ssl_tunnel_start_ip = "${var.ssl_tunnel_start_ip}"
    ssl_tunnel_end_ip = "${var.ssl_tunnel_end_ip}"

  }
}
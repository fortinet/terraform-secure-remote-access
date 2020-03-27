
data "template_file" "setupFortiGate" {
  template = "${file("${path.module}/configscripts/fortigateconfig")}"
  vars = {
    psk_key     = "${var.psk_key}",
    remote_subnet = "${var.remote_subnet}"
    remote_subnet_netmask = "${var.remote_subnet_netmask}"

  }
}
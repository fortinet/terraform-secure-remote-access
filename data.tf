
data "template_file" "setupFortiGate" {
  template = "${file("${path.module}/configscripts/fortigateconfig")}"
  vars = {
    psk_key     = "${var.psk_key}",

  }
}
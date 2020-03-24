# Configure the Azure Provider
# Values can be found by az login / az account get-access-token
provider "azurerm" {
    version = "=1.28.0"

  client_id = "${var.client_id}"
  subscription_id = "${var.subscription_id}"
  tenant_id = "${var.tenant_id}"
}

#Random 5 char string appended to the end of each name to avoid conflicts
resource "random_string" "random_name_post" {
  length           = 5
  special          = true
  override_special = ""
  min_lower        = 5
}
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.cluster_name}-rsg-${random_string.random_name_post.result}"
  location = "${var.region}"
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "external_network" {
  name                = "${var.cluster_name}-vpc-${random_string.random_name_post.result}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location            = "${azurerm_resource_group.resource_group.location}"
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.external_network.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.cluster_name}-nic-${random_string.random_name_post.result}"
  location            = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"


  ip_configuration {
    name                          = "${var.cluster_name}-IP-${random_string.random_name_post.result}"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id  = "${azurerm_public_ip.public_ip.id}"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.cluster_name}-vm-${random_string.random_name_post.result}"
  location              = "${azurerm_resource_group.resource_group.location}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS1_v2"
  delete_os_disk_on_termination = true
  plan {
    name = "fortinet_fg-vm_payg_20190624" //"fortinet_fg-vm" //Pay as you go: "fortinet_fg-vm_payg_20190624"
    publisher = "fortinet"
    product = "fortinet_fortigate-vm_v5"
  }

  storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortigate-vm_v5"
    sku       =  "fortinet_fg-vm_payg_20190624" //"fortinet_fg-vm" //Pay as you go: "fortinet_fg-vm_payg_20190624"M
    version   = "latest"
  }
    storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
    os_profile {
    computer_name  = "hostname"
    admin_username = "${var.admin_name}"
    admin_password =  "${var.admin_password}"
  }
    os_profile_linux_config {
    disable_password_authentication = false
  }

  ####SLB Resources ###
}
resource "azurerm_public_ip" "public_ip" {
  name                = "PublicIPForFortiGate"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  allocation_method   = "Static"
}

output "ResourceGroup" {
  value = "${azurerm_resource_group.resource_group.id}"
}
output "PublicIP" {
  value = "${azurerm_public_ip.public_ip.ip_address}"
}
output "AdminPassword" {
  value ="${var.admin_password}"
}
output "AdminName" {
  value ="${var.admin_name}"
}
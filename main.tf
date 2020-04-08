# Configure the Azure Provider
# Values can be found by az login / az account get-access-token
provider "azurerm" {
  version         = "=1.44.0"
  client_id       = "${var.client_id}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
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
  location = var.region
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "external_network" {
  name                = "${var.cluster_name}-vpc-${random_string.random_name_post.result}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  // address_space       = ["10.0.0.0/16"]
  address_space = var.external_address_space
}
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.external_network.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.cluster_name}-nic-${random_string.random_name_post.result}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name


  ip_configuration {
    name                          = "${var.cluster_name}-IP-${random_string.random_name_post.result}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_virtual_machine" "fgt-hub" {
  name                          = "${var.cluster_name}-vm-${random_string.random_name_post.result}"
  location                      = azurerm_resource_group.resource_group.location
  resource_group_name           = azurerm_resource_group.resource_group.name
  network_interface_ids         = ["${azurerm_network_interface.main.id}"]
  vm_size                       = var.hub_vm_size
  delete_os_disk_on_termination = true
  plan {
    name      = var.fgt_sku
    publisher = "fortinet"
    product   = var.fgt_product
  }

  storage_image_reference {
    publisher = "fortinet"
    offer     = var.fgt_product
    sku       = var.fgt_sku
    version   = var.fgt_version
  }
  storage_os_disk {
    name              = "osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "FortiGateSecureAccess"
    admin_username = var.admin_name
    admin_password = var.admin_password
    custom_data    = data.template_file.setupFortiGate.rendered
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

}
resource "azurerm_public_ip" "public_ip" {
  name                = "PublicIPForFortiGate"
  location            = var.region
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

output "ResourceGroup" {
  value = azurerm_resource_group.resource_group.name
}
output "PublicIP" {
  value = "${join("", list("https://", "${azurerm_public_ip.public_ip.ip_address}", ":8443"))}"
}
output "AdminPassword" {
  value = var.admin_password
}
output "AdminName" {
  value = var.admin_name
}

output "EasyKey" {
  value       = base64encode("${data.template_file.easy_key_setup.rendered}")
  description = "Use this key to in the Spoke setup to generate the VPN config."
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}
resource "azurerm_virtual_network" "Vnet" {
  name                = var.Vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.Vnet_address
  tags                = var.tags
}

resource "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.subnet_address
  virtual_network_name = azurerm_virtual_network.Vnet.name
}

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  tags                = var.tags
  domain_name_label   = var.domain_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "http" {
  name                        = var.nsg_rule_name[0]
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.unknown_variable
  destination_port_range      = "80"
  source_address_prefix       = var.unknown_variable
  destination_address_prefix  = var.unknown_variable
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = var.nsg_rule_name[1]
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.unknown_variable
  destination_port_range      = "22"
  source_address_prefix       = var.unknown_variable
  destination_address_prefix  = var.unknown_variable
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface" "NIC" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = var.ipconf_name
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nic_ass" {
  network_interface_id      = azurerm_network_interface.NIC.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm_l" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  size                            = var.vm_sku
  admin_username                  = var.user_name
  admin_password                  = var.vm_password
  network_interface_ids           = [azurerm_network_interface.NIC.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = var.os_version
    sku       = var.os_version
    version   = "latest"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type     = "ssh"
      user     = var.user_name
      password = var.vm_password
      host     = azurerm_public_ip.pip.ip_address
    }
  }
  tags = var.tags
}
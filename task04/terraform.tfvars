rg_name                = "cmaz-0sj5vwga-mod4-rg"
location               = "eastus"
tags                   = { "Creator" = "levon_khalatyan@epam.com" }
Vnet_name              = "cmaz-0sj5vwga-mod4-vnet"
subnet_name            = "frontend"
Vnet_address           = ["10.0.0.0/16"]
subnet_address          = ["10.0.1.0/24"]
unknown_variable       = "*"
public_ip_name         = "cmaz-0sj5vwga-mod4-pip"
nsg_name               = "cmaz-0sj5vwga-mod4-nsg"
nsg_rule_name          = ["AllowHTTP", "AllowSSH"]
network_interface_name = "cmaz-0sj5vwga-mod4-nic"
domain_name            = "cmaz-0sj5vwga-mod4-nginx"
vm_name                = "cmaz-0sj5vwga-mod4-vm"
vm_sku                 = "Standard_B2s_v2"
os_version             = "ubuntu-24_04-lts"
user_name              = "adminLevon"
user_password          = "Password12345!"
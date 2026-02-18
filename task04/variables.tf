variable "rg_name" {
  type        = string
  description = "This variable is the name of resource group."
}

variable "location" {
  type        = string
  description = "This variable is the location of all resource."
}

variable "tags" {
  type        = map(string)
  description = "This variable is the tag of all resource."
}

variable "Vnet_name" {
  type        = string
  description = "This variable is the name of Virtual Network."
}

variable "Vnet_address" {
  type        = list(string)
  description = "This variable is the range of Vnet address."
}

variable "subnet_address" {
  type        = list(string)
  description = "This variable is the range of subnet address."
}

variable "subnet_name" {
  type        = string
  description = "This variable is the name of subnet."
}

variable "public_ip_name" {
  type        = string
  description = "This variable is the name of Public Ip."
}

variable "nsg_name" {
  type        = string
  description = "This variable is the name of nsg."
}

variable "nsg_rule_name" {
  type        = list(string)
  description = "This variable is the name of nsg rule"
}

variable "network_interface_name" {
  type        = string
  description = "This variable is the name of NIC."
}

variable "domain_name" {
  type        = string
  description = "This variable is the dns name of public Ip."
}

variable "vm_name" {
  type        = string
  description = "This variable is the name of VM."
}

variable "vm_sku" {
  type        = string
  description = "This variable is the size of VM."
}

variable "os_version" {
  type        = string
  description = "This variable is os verison."
}

variable "user_name" {
  type        = string
  description = "This variable is username."
}

variable "vm_password" {
  type        = string
  sensitive   = true
  description = "This variable is user password."
}

variable "ipconf_name" {
  type        = string
  description = "This variable is ip config name"
}
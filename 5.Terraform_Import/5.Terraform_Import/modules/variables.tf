variable "rgname" {
  type = string
  description = "used for naming a resource group"
}

variable "rglocation" {
  type = string
  description = "used for rg location"
  default = "East Europe"
}

variable "vnet" {
  type = string
  description = "used for assign vnet"
}

variable "vnet_address" {
  type = string
  description = "used to assign ip address"
}

variable "subnet1" {
    type = string
    description = "used to assign subnet ip"
  
}

variable "nsg2" {
  type = string
  description = "used for nsg"
}
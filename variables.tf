variable "name" {
  default     = "terraform"
  description = "Name of the virtual network"
}

variable "location" {
  default = "South UK"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  default = ["10.0.0.0/24"]
}

variable "env" {
  type    = "string"
  default = "local"
}

variable "lb_private_ip_address" {
  description = "Private IP address of the of the DNS consul cluster loadbalancer"
}

variable "microsoft_external_dns" {
  default     = ["168.63.129.16"]
  description = "List of external DNS servers"
}

variable "ephemeral" {}

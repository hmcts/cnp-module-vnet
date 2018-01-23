variable "name" {
  default     = "terraform"
  description = "Name of the virtual network"
}

variable "location" {
  default = "South UK"
}

variable "address_space" {}

variable "env" {
  type    = "string"
  default = "local"
}

variable "lb_private_ip_address" {}

variable "source_range" {
  type = "string"
}

variable "microsoft_external_dns" {
  default     = ["168.63.129.16", "172.16.0.10"]
  description = "List of external DNS servers, default currently including tactical dns."
}

variable "ephemeral" {}


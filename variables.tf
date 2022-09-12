variable "name" {
  default     = "terraform"
  description = "Name of the virtual network"
}

variable "location" {
  default = "South UK"
}

variable "address_space" {}

variable "env" {
  type    = string
  default = "local"
}

variable "lb_private_ip_address" {
  type = string
}

variable "source_range" {
  type = string
}

variable "microsoft_external_dns" {
  default     = ["168.63.129.16", "172.16.0.10", "172.16.0.14"]
  description = "List of external DNS servers, default currently including tactical dns."
}

variable "common_tags" {
  type = map(string)
  default = {
    "Team Name" = "pleaseTagMe"
  }
}

variable "iaas_subnet_enforce_private_link_endpoint_network_policies" {
  default = true
}

variable "postgresql_subnet_cidr_blocks" {
  type    = set(string)
  default = []
}

variable "postgresql_subnet_cidr" {}
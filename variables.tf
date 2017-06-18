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

variable "subnetinstance_count" {
  default = 1
}

variable "tag" {
  type    = "string"
  default = "local"
}

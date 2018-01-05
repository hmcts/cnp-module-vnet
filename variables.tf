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

variable "env" {
  type    = "string"
  default = "local"
}

variable "source_range" {
  type = "string"
}
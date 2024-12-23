variable "latitudesh_token" {
  description = "Latitude.sh API token"
}

variable "plan" {
  description = "Latitude.sh server plan"
  default     = "s3-large-x86"
}

variable "region" {
  description = "Latitude.sh server region slug"
  default     = "ASH"
}

variable "ssh_public_key" {
  description = "Latitude.sh SSH public key"
}

variable "environment" {
  description = "Runtime environment"
}

variable "hostname" {
  description = "Server host name"
}

variable "operating_system" {
  description = "Server operation system"
}
 variable "ssh_key_owner" {
   description = "SSH Key Owner"
 }
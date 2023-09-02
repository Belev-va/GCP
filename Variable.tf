#General variables
variable "region" {
  type        = string
  default     = "us-west4-b"
  description = "The GCP region to deploy resources in."
}

variable "zone" {
  type        = string
  default     = "c"
  description = "The GCP zone to deploy resources in."
}

variable "cidr_range" {
  type        = string
  default     = "192.168.1.0/24"
  description = "The IP CIDR range to use for the cluster's VPC subnetwork."
}

#Another variables

variable "name" {
  type        = string
  default     = "howlight"
  description = "The default name to use for resources."
}
variable "client_count" {
  default = "1"
}

#Variables for servers

variable "server_machine_type" {
  type        = string
  default     = "e2-medium"
  description = "The compute engine machine type to use for server instances."
}

variable "client_machine_type" {
  type        = string
  default     = "e2-medium"
  description = "The compute engine machine type to use for client instances."
}

variable "server_disk_size_gb" {
  type        = string
  default     = "20"
  description = "The compute engine disk size in GB to use for server instances."
}

variable "client_disk_size_gb" {
  type        = string
  default     = "20"
  description = "The compute engine disk size in GB to use for client instances."
}
variable "image" {
  type        = string
  default     = "centos-7-v20230809"
  description = "The GCP image name (built with Packer)."
}

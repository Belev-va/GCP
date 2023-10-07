#General variables
variable "region" {
  type        = string
  default     = "europe-west1"
  description = "The GCP region to deploy resources in."
}

variable "zone" {
  type        = string
  default     = "b"
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
  default = "2"
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
variable "ssh_user" {
  type        = string
  default     = "root"
  description = "The GCP default user for ssh connection."
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "C:/Users/kissi/IdeaProjects/GCP/pubkey_gcp"
}

variable "service_account_email" {
  description = "The service account e-mail address. If not given, the default Google Compute Engine service account is used. Note: allow_stopping_for_update must be set to true in order to update this field."
  default     = "131924832816-compute@developer.gserviceaccount.com"
}

variable "service_account_scopes" {
  description = "A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope. Note: allow_stopping_for_update must be set to true in order to update this field."
  default     = []
}
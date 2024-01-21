                                //---GCP---\\
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

variable "instance_count" {
   type        = string
   default     = "2"
   description = "Count of instances"
}
 variable "instance_name" {
   type        = string
   default     = "k8s"
   description = "Name for instances."
 }
# Configuration variables

variable "instance_type" {
  type        = string
  default     = "e2-medium"
  description = "The compute engine machine type to use for client instances."
}

variable "disk_size" {
  type        = string
  default     = "20"
  description = "The compute engine disk size in GB to use for server instances."
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
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

                                        //-----aws---\\\
 /*

variable "instance_subnet_id" {
  type        = list(string)
  default     = []
  description = "Subnet id for instance."
}

variable "instance_security_group" {
  type        = list(string)
  default     = []
  description = "Security group for instance."
}

variable "instance_key_name" {
  type        = string
  default     = "deployer-key"
  description = "Key name for instance"
}

*/


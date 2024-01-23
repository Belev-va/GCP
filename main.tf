terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  credentials = file("howlight-398ab17777d1.json")
  project = "howlightuniversity-000001"
  region  = var.region

}


module "firewall"{
  source       = "./firewall"
}

module "master_nods" {
  source                  = "./instance"
  instance_name           = "master"
  instance_type           = "n2-standard-2"
  instance_count          = 3
  #instance_subnet_id      = module.network.private_subnet_id
  #instance_security_group = [module.security_group.private_security_group_id]

}

module "worker_nods" {
  source                  = "./instance"
  instance_name           = "worker"
  instance_count          = 3
  #instance_subnet_id      = module.network.public_subnet_id
  #instance_security_group = [module.security_group.public_security_group_id]
}

module "jenkins_nods" {
  source                  = "./instance"
  instance_name           = "jenkins"
  instance_count          = 1
  #instance_subnet_id      = module.network.public_subnet_id
  #instance_security_group = [module.security_group.public_security_group_id]
}
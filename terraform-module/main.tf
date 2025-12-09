# VPC Module
module "vpc" {
  source = "./modules/vpc"
  region= var.region
  az_1= var.az_1
  az_2= var.az_2
  vpc_id = var.vpc_id
  vpc_cidr_block= var.vpc_cidr
  public_sub_cidr= var.public_cidr
  private_sub_cidr = var.private_cidr
  project = "Terraform"
}

# Launch-temp-1 Module
module "asg-template_1" {
  source = "./modules/alb"
  region = var.region
  az_1 = var.az_1
  vpc_id = var.vpc_id
  name1= var.name1
  ami_id = var.ami_id
  instance_type = var.instance_type
  project = "Terraform"
}
# Launch-temp-2 Module
module "asg-template_2" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  az_2 = var.az_2
  name2= var.name2
  ami_id = var.ami_id
  instance_type = var.instance_type
  project = "Terraform"
}


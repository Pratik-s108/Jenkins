# VPC Module
module "vpc" {
  source = "./module/vpc"
  region= var.region
  az_1= var.az_1
  az_2= var.az_2
  vpc_cidr_block= var.vpc_cidr
  public_sub_cidr= var.public_cidr
  private_sub_cidr = var.private_cidr
  project = "Terraform"
}

# Launch-temp-1 Module
module "asg-template_1" {
  source = "./module/alb"
  region = var.region
  az_1 = var.az_1
  name1= var.name1
  ami_id = var.ami_id
  instance_type = var.instance_type
  project = "Terraform"
}
# Launch-temp-2 Module
module "asg-template_2" {
  source = "./module/alb"
  az_2 = var.az_2
  name2= var.name2
  ami_id = var.ami_id
  instance_type = var.instance_type
  project = "Terraform"
}

# ALB module
module "alb" {
  source = "./module/alb"
  vpc_id = module.vpc.vpc_id
  subnets_id = module.vpc.subnets_id
  region = "ap-south-1"
}

#RDS module
module "rds" {
  source = "./module/rds"
  GB = 20
  db_name = "my_db"
  engine_name = "mariadb"
  engine_version = "11.4.8"
  instance_class = "db.t4g.micro"
  username = "pratik"
  password = "123"

}
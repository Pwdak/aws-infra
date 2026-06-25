provider "aws" {
  region = var.aws_region
}

module "network" {
  source              = "../../modules/network"
  project             = var.project
  environment         = var.environment
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  availability_zone   = "${var.aws_region}a"
}

module "security" {
  source           = "../../modules/security"
  project          = var.project
  vpc_id           = module.network.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

module "iam" {
  source  = "../../modules/iam"
  project = var.project
}

module "ec2" {
  source                 = "../../modules/ec2"
  project                = var.project
  environment            = var.environment
  ami_id                 = var.ami_id
  subnet_id              = module.network.subnet_id
  sg_id                  = module.security.ec2_sg_id
  instance_profile_name  = module.iam.instance_profile_name
  key_name               = var.key_name
}
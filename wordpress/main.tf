provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tf-state-dev-obent"
    key    = "dev/network/terraform.tfstate"
    region = "eu-west-1"
  }
}

module "vpc-dev" {
  source = "../modules/aws_network"
  
  vpc_cidr = "10.0.0.0/16"
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidrs =  ["10.0.101.0/24", "10.0.102.0/24"]
  env = "dev"
  
}
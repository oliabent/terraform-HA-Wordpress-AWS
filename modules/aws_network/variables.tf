variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default = []
}

variable "private_subnet_cidrs" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default = []
}

variable "env" {
  description = "Name of environment"
  default = "default-env"
}
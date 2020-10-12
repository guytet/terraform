# Input variable definitions

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "vpc-from-module"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["172.31.0.0/24", "172.31.1.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["172.31.2.0/24", "172.31.3.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "trusted-ip" {
  default = [""]
}

variable "ami_id" {
  default = "ami-07d25496ed9d672f0"
}

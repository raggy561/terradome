variable "region" {
  description = "AWS Region"
  type = string
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "cidr block for VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "project_name" {
    description = "name of current project"
    type=string
    default="terradome"
}

variable "environment" {
    description = "name of environment"
    type=string
    default="dev"  
}

variable "instance_type" {
  description = "AWS EC2 Instance Type"
  type=string
  default = "t3.micro"
}

variable "my_ip" {
  description = "My Public IP in CIDR notation, for SSH Access"
  type = string
}



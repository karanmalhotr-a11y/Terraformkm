variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}
variable "aws_profile" {
  description = "AWS CLI profile to use from ~/.aws/credentials file"
  type        = string
  default     = "default"
}
variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  default     = "terraform-projectkm"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0236922087fa98b6e" # Amazon Linux 2 (update for your region)
}

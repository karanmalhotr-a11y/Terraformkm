# Terraform Variables File
# Customize these values for your environment

aws_region   = "us-east-1"
aws_profile  = "default"  # Use "production" for production credentials
project_name = "terraform-projectkm"
environment  = "dev"
vpc_cidr     = "10.0.0.0/16"
subnet_cidr  = "10.0.1.0/24"
instance_type = "t3.micro"
ami_id       = "ami-0236922087fa98b6e" # Amazon Linux 2 (update for your region)

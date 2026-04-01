terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Networking - Minimal setup with 1 public subnet, no NAT
module "networking" {
  source = "../../modules/networking"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = [] # No private subnets
  availability_zones   = [var.availability_zones[0]]
  enable_nat_gateway   = false # No NAT to save costs

  tags = var.tags
}

# EC2 Instance
module "ec2" {
  source = "../../modules/ec2"

  environment         = var.environment
  instance_name       = var.instance_name
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  vpc_id              = module.networking.vpc_id
  subnet_id           = module.networking.public_subnet_ids[0]
  associate_public_ip = true
  key_name            = var.key_name
  allow_ssh           = var.allow_ssh
  allow_http          = true
  allowed_ssh_cidrs   = var.allowed_ssh_cidrs
  root_volume_size    = 20

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Welcome to ${var.environment} Environment</h1>" > /var/www/html/index.html
    echo "<p>Instance: ${var.instance_name}</p>" >> /var/www/html/index.html
    echo "<p>Environment: ${var.environment}</p>" >> /var/www/html/index.html
  EOF

  tags = var.tags
}

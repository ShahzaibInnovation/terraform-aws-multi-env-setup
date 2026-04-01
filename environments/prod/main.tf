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

# Networking - Full setup with public/private subnets and NAT
module "networking" {
  source = "../../modules/networking"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_nat_gateway   = true # NAT enabled for production

  tags = var.tags
}

# Public Web Server
module "ec2_web" {
  source = "../../modules/ec2"

  environment          = var.environment
  instance_name        = "web-server"
  ami_id               = var.ami_id
  instance_type        = var.instance_type_web
  vpc_id               = module.networking.vpc_id
  subnet_id            = module.networking.public_subnet_ids[0]
  associate_public_ip  = true
  key_name             = var.key_name
  allow_ssh            = var.allow_ssh
  allow_http           = true
  allow_https          = true
  allowed_ssh_cidrs    = var.allowed_ssh_cidrs
  root_volume_size     = 30

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Welcome to ${var.environment} Environment</h1>" > /var/www/html/index.html
    echo "<p>Server: Web Server (Public)</p>" >> /var/www/html/index.html
    echo "<p>Environment: ${var.environment}</p>" >> /var/www/html/index.html
  EOF

  tags = var.tags
}

# Private App Server
module "ec2_app" {
  source = "../../modules/ec2"

  environment          = var.environment
  instance_name        = "app-server"
  ami_id               = var.ami_id
  instance_type        = var.instance_type_app
  vpc_id               = module.networking.vpc_id
  subnet_id            = module.networking.private_subnet_ids[0]
  associate_public_ip  = false
  key_name             = var.key_name
  allow_ssh            = var.allow_ssh
  allow_http           = false
  allow_https          = false
  allowed_ssh_cidrs    = var.allowed_ssh_cidrs
  root_volume_size     = 30

  tags = var.tags
}

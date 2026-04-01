variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type_web" {
  description = "EC2 instance type for web server"
  type        = string
  default     = "t3.small"
}

variable "instance_type_app" {
  description = "EC2 instance type for app server"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0ec10929233384c7f"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = null
}

variable "allow_ssh" {
  description = "Allow SSH"
  type        = bool
  default     = true
}

variable "allowed_ssh_cidrs" {
  description = "SSH allowed CIDRs - RESTRICT in production"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Change to your office IP in production
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default = {
    Project     = "Multi-Env-Project"
    ManagedBy   = "Terraform"
    Environment = "prod"
  }
}

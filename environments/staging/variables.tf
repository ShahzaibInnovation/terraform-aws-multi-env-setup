variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "web-server"
}

variable "instance_type" {
  description = "EC2 instance type"
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

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a"]
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
  description = "SSH allowed CIDRs"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default = {
    Project     = "Multi-Env-Project"
    ManagedBy   = "Terraform"
    Environment = "staging"
  }
}

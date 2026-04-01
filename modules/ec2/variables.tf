variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0ec10929233384c7f" # Ubuntu image in us-east-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate public IP"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = null
}

variable "allow_ssh" {
  description = "Allow SSH access"
  type        = bool
  default     = false
}

variable "allow_http" {
  description = "Allow HTTP access"
  type        = bool
  default     = false
}

variable "allow_https" {
  description = "Allow HTTPS access"
  type        = bool
  default     = false
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "root_volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Root volume size"
  type        = number
  default     = 20
}

variable "root_volume_encrypted" {
  description = "Encrypt root volume"
  type        = bool
  default     = true
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

# Security Group
resource "aws_security_group" "ec2" {
  name_prefix = "${var.environment}-${var.instance_name}-"
  description = "Security group for ${var.environment} ${var.instance_name}"
  vpc_id      = var.vpc_id

  # SSH access
  dynamic "ingress" {
    for_each = var.allow_ssh ? [1] : []
    content {
      description = "SSH from allowed CIDRs"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.allowed_ssh_cidrs
    }
  }

  # HTTP access
  dynamic "ingress" {
    for_each = var.allow_http ? [1] : []
    content {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # HTTPS access
  dynamic "ingress" {
    for_each = var.allow_https ? [1] : []
    content {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.instance_name}-sg"
  })
}

# EC2 Instance
resource "aws_instance" "main" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = var.associate_public_ip
  key_name                    = var.key_name

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.root_volume_encrypted
  }

  user_data = var.user_data

  tags = merge(var.tags, {
    Name        = "${var.environment}-${var.instance_name}"
    Environment = var.environment
  })

  lifecycle {
    create_before_destroy = true
  }
}

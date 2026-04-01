terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-ctk56" 
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-prod"
    encrypt        = true
  }
}

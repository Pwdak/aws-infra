terraform {
  backend "s3" {
    bucket         = "monentreprise-tfstate-dev"
    key            = "ec2-stack/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-locks-dev"
    encrypt        = true
  }
}
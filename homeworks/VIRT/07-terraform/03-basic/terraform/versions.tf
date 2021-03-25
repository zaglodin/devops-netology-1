terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-netology"
    key    = "tf_state_file"
    region = "eu-north-1"
  }
}

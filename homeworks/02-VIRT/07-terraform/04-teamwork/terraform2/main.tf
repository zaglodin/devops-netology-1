provider "aws" {
  region = "eu-north-1"
}

data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/27"
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "my-cluster"
  instance_count         = 2
  ami                    = "ami-0ed17ff3d78e74700"
  instance_type          = "t3.micro"
  monitoring             = true
  vpc_security_group_ids = [aws_vpc.main_vpc.default_security_group_id]
  subnet_id              = aws_subnet.main_subnet.id
}
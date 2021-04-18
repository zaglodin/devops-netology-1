provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/27"
}

resource "aws_instance" "test" {
  ami                                  = "ami-0ed17ff3d78e74700"
  instance_type                        = local.instance_type[terraform.workspace]
  count                                = local.instance_count[terraform.workspace]
  subnet_id                            = aws_subnet.main_subnet.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "another_test" {
  for_each = (terraform.workspace == "prod" ? local.instance_prod : local.instance_stage)
  ami                                  = "ami-0ed17ff3d78e74700"
  instance_type                        = each.value
  subnet_id                            = aws_subnet.main_subnet.id
}
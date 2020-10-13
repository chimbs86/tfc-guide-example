provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

resource "aws_vpc" "production" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}

resource "aws_vpc" "development" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "development"
  }
}

resource "aws_vpc" "edge" {
  cidr_block       = "10.3.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "edge"
  }
}

resource "aws_vpc" "shared" {
  cidr_block       = "10.4.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "shared"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.production.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "production"
  }
}
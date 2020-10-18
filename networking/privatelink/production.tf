resource "aws_vpc" "production_customer" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_customer_a" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "production"
  }
}


resource "aws_vpc" "production_marketing" {
  cidr_block = "10.4.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_marketing_a" {
  vpc_id = aws_vpc.production_marketing.id
  cidr_block = "10.4.1.0/24"

  tags = {
    Name = "production"
  }
}


resource "aws_vpc" "production_finance" {
  cidr_block = "10.5.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_finance_a" {
  vpc_id = aws_vpc.production_finance.id
  cidr_block = "10.5.1.0/24"

  tags = {
    Name = "production"
  }
}



resource "aws_lb" "load_balancer" {
  name = "test-network-lb"
  #can also be obtained from the variable nlb_config
  load_balancer_type = "network"
  internal = true
  subnet_mapping {
    subnet_id = aws_subnet.production_customer_a.id
  }
  tags = {
    Environment = "prod"
  }
}

resource "aws_vpc_endpoint_service" "example" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.load_balancer.arn]
}

resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint_service.example.id
  subnet_id       = aws_subnet.production_finance_a.id
}
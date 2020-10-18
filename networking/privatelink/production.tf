resource "aws_vpc" "production" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_customer" {
  vpc_id = aws_vpc.production.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "production"
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id = aws_vpc.production.id
  vpc_id = aws_vpc.development.id
  auto_accept = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}
resource "aws_eip" "eip_nlb" {
  tags = {
    Name = "test-network-lb-eip"
    Env = "test"
  }
}
resource "aws_lb" "load_balancer" {
  name = "test-network-lb"
  #can also be obtained from the variable nlb_config
  load_balancer_type = "network"
  subnet_mapping {
    subnet_id = aws_subnet.production_customer.id
    allocation_id = aws_eip.eip_nlb.id
  }
  tags = {
    Environment = "prod"
  }
}
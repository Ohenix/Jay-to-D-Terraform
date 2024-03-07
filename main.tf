# Networking for the Application

resource "aws_vpc" "Oct-Vpc" {
  cidr_block       = "10.0.0.0/18"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Oct-Vpc"
    env = "test"
  }
}


#Creating 2 Public and 2 private Subnets

resource "aws_subnet" "Oct-Pub-sub1" {
  vpc_id     = aws_vpc.Oct-Vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Oct-Pub-sub1"
    env = "test"
  }
}

resource "aws_subnet" "Oct-Pub-sub2" {
  vpc_id     = aws_vpc.Oct-Vpc.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Oct-Pub-sub2"
    env = "test"
  }
}

resource "aws_subnet" "Oct-Priv-sub1" {
  vpc_id     = aws_vpc.Oct-Vpc.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Oct-Priv-sub1"
    env = "test"
  }
}

resource "aws_subnet" "Oct-Priv-sub2" {
  vpc_id     = aws_vpc.Oct-Vpc.id
  cidr_block = "10.0.14.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Oct-Priv-sub2"
    env = "test"
  }
}

# CREATING BOTH PUBLIC AND PRIVATE ROUTE TABLE

resource "aws_route_table" "Oct-Pub-RT" {
  vpc_id = aws_vpc.Oct-Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Oct-IGW.id
  }

  tags = {
    Name = "Oct-Pub-RT"
  }
}

resource "aws_route_table" "Oct-Priv-RT" {
  vpc_id = aws_vpc.Oct-Vpc.id

 
  tags = {
    Name = "Oct-Priv-RT"
  }
}


# ASSOCIATION OF ROUTE TABLES TO THE SUBNETS

resource "aws_route_table_association" "assoc-1" {
  subnet_id      = aws_subnet.Oct-Pub-sub1.id
  route_table_id = aws_route_table.Oct-Pub-RT.id
}

resource "aws_route_table_association" "assoc-2" {
  subnet_id      = aws_subnet.Oct-Pub-sub2.id
  route_table_id = aws_route_table.Oct-Pub-RT.id
}


resource "aws_route_table_association" "assoc-3" {
  subnet_id      = aws_subnet.Oct-Priv-sub1.id
  route_table_id = aws_route_table.Oct-Priv-RT.id
}

resource "aws_route_table_association" "assoc-4" {
  subnet_id      = aws_subnet.Oct-Priv-sub2.id
  route_table_id = aws_route_table.Oct-Priv-RT.id
}


# Create Internet gateway

resource "aws_internet_gateway" "Oct-IGW" {
  vpc_id = aws_vpc.Oct-Vpc.id

  tags = {
    Name = "Oct-IGW"
  }
}







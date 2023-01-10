// vpc configuration
# Variable that holds the CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
}

# Creting the VPC and calling it tutorial_vpc
resource "aws_vpc" "aws_vpc" {
  # Setting the CIDR block of the VPC to the variable vpc_cidr_block
  cidr_block = var.vpc_cidr_block

  # Enabling DNS hostnames on the VPC
  enable_dns_hostnames = true

  # Setting the tag Name to tutorial_vpc
  tags = {
    Name = "aws_vpc"
  }
}

// route configuration
resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.aws_vpc.id

  tags = {
    Name = "aws_igw"
  }
}

resource "aws_route_table" "aws_public_rt" {
  vpc_id = aws_vpc.aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_igw.id
  }
}


// subnet configuration
variable "public_subnet_cidr_block" {
  description = "CIDR block of the public subnet"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "aws_public_subnet" {
  vpc_id            = aws_vpc.aws_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "aws_public_subnet"
  }
}

# Associating our public subnet with our public route table
resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.aws_public_rt.id
  subnet_id      = aws_subnet.aws_public_subnet.id
}

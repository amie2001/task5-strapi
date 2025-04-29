resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet-public-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "subnet_public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-subnet-public-2"
  }
}

# Internet Gateway (IGW)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-route-table-public"
  }
}

# Public Route to IGW
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate Subnets with Route Table
resource "aws_route_table_association" "subnet_public_1_association" {
  subnet_id      = aws_subnet.subnet_public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_public_2_association" {
  subnet_id      = aws_subnet.subnet_public_2.id
  route_table_id = aws_route_table.public.id
}

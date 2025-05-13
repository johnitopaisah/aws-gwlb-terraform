resource "aws_vpc" "aws_course" {
  cidr_block = "31.0.0.0/16"
  tags = {
    Name = "AWS Course VPC"
  }
}

resource "aws_vpc" "security" {
  cidr_block = "81.0.0.0/16"
  tags = {
    Name = "Security VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.aws_course.id
  cidr_block = "31.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.aws_course.id
  cidr_block = "31.0.2.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "security_private" {
  vpc_id     = aws_vpc.security.id
  cidr_block = "81.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_internet_gateway" "course_gw" {
  vpc_id = aws_vpc.aws_course.id
}

resource "aws_internet_gateway" "security_gw" {
  vpc_id = aws_vpc.security.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.aws_course.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.course_gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
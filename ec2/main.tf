resource "aws_instance" "public_ec2" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "Public EC2"
  }
}

resource "aws_instance" "private_ec2" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  tags = {
    Name = "Private EC2"
  }
}

resource "aws_instance" "security_appliance" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.security_subnet_id
  tags = {
    Name = "Appliance"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

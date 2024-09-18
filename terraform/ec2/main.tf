provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "thm_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "THM-VPC"
    Project = "THM-ECG"
  }
}

resource "aws_subnet" "thm_public_subnet" {
  vpc_id                  = aws_vpc.thm_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "THM-Public-Subnet"
    Project = "THM-ECG"
  }
}

resource "aws_subnet" "thm_private_subnet" {
  vpc_id            = aws_vpc.thm_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "THM-Private-Subnet"
    Project = "THM-ECG"
  }
}

resource "aws_internet_gateway" "thm_igw" {
  vpc_id = aws_vpc.thm_vpc.id
  tags = {
    Name = "THM-Internet-Gateway"
    Project = "THM-ECG"
  }
}

resource "aws_route_table" "thm_public_route_table" {
  vpc_id = aws_vpc.thm_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.thm_igw.id
  }
  tags = {
    Name = "THM-Public-Route-Table"
    Project = "THM-ECG"
  }
}

resource "aws_route_table_association" "thm_public_association" {
  subnet_id      = aws_subnet.thm_public_subnet.id
  route_table_id = aws_route_table.thm_public_route_table.id
}

resource "aws_security_group" "thm_security_group" {
  vpc_id = aws_vpc.thm_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "THM-Security-Group"
    Project = "THM-ECG"
  }
}

data "aws_ami" "ubuntu22" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "thm_backend_server" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.thm_public_subnet.id
  security_groups = [aws_security_group.thm_security_group.id]
  associate_public_ip_address = true
  key_name = "thm-ecg-backend"
  tags = {
    Name = "THM-Backend-Server"
    Project = "THM-ECG"
  }
}

# Uncomment and adjust the following if you need a frontend server in the public subnet
# resource "aws_instance" "thm_frontend_server" {
#   ami           = data.aws_ami.ubuntu22.id
#   instance_type = "t2.medium"
#   subnet_id     = aws_subnet.thm_public_subnet.id
#   security_groups = [aws_security_group.thm_security_group.id]
#   associate_public_ip_address = true
#   tags = {
#     Name = "THM-Frontend-Server"
#     Project = "THM-ECG"
#   }
# }

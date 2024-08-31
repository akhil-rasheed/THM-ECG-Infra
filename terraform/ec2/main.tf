provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.medium"

  tags = {
    Name = "BackendAndDatabase"
  }
}


resource "aws_instance" "frontend_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.medium"

  tags = {
    Name = "Frontend"
  }
}

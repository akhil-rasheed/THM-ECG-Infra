provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "backend_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "BackendAndDatabase"
  }
}


resource "aws_instance" "frontend_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "Frontend"
  }
}

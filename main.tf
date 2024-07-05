provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ff591da048329e00"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}
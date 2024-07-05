provider "aws" {
  region = "us-west-1"
}

resource "aws_security_group" "example_sg" {
  name_prefix = "example_sg"

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "ExampleSecurityGroup"
  }
}

resource "aws_instance" "example" {
  ami             = "ami-0ff591da048329e00"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.example_sg.name]
  key_name        = "projects"  # Reference the existing key pair name here

  tags = {
    Name = "ExampleInstance"
  }
}

output "app_url" {
  value = "http://${aws_instance.example.public_ip}"
}

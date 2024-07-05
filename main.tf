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

  ingress {
    from_port   = 22
    to_port     = 22
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

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<html><body><h1>Sample Web App</h1></body></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "ExampleInstance"
  }
}

output "app_url" {
  value = "http://${aws_instance.example.public_ip}"
}

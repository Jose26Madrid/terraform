provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "ssh_web_access" {
  name        = "ssh_web_access"
  description = "Permitir SSH y acceso web"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SonarQube UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
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
}

resource "aws_instance" "django_sonar_spot" {
  ami                    = "ami-08f9a9c699d2ab3f9"
  instance_type          = "t3.large"
  key_name               = "aws"
  vpc_security_group_ids = [aws_security_group.ssh_web_access.id]

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type = "one-time"
    }
  }

  associate_public_ip_address = true

  tags = {
    Name = "Django-Sonar-Spot"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y git docker
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              docker-compose version
              sudo sysctl -p
              sudo dnf install -y tree
              EOF
}

output "acceso_instancia" {
  value       = "Accede a la IP ${aws_instance.django_sonar_spot.public_ip} usando los siguientes puertos: SSH (22), HTTP (80), HTTPS (443), SonarQube UI (9000)"
  description = "IP pública y puertos disponibles para acceso"
}

output "id_instancia" {
  value       = aws_instance.django_sonar_spot.id
  description = "ID de la instancia EC2 creada"
}


# MIT License
# Copyright (c) 2025 Jose Magariño
# See LICENSE file for more details.
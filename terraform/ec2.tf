provider "aws" {
  region = "us-east-1"
}

# ✅ Security Group (THIS FIXES SSH)
resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH access"

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # for lab (we tighten later)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ✅ EC2 Instance
resource "aws_instance" "linux_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  key_name = "linux-lab-key"

  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "LinuxLabServer"
  }
}
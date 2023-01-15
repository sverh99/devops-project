variable "security_group" {
  description = "The security groups assigned to the Jenkins server"
}

# Variable where we will pass in the subnet ID
variable "public_subnet" {
  description = "The public subnet IDs assigned to the Jenkins server"
}

variable "docker_registry_password" {
  description = "Docker registry password"
}

variable "docker_registry_username" {
  description = "Docker registry username"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.public_subnet
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.security_group]
  key_name               = aws_key_pair.aws_kp.key_name
  user_data = templatefile("${path.module}/install_jenkins.sh", {
    docker_user = var.docker_registry_username
    docker_pass = var.docker_registry_password
  })

  tags = {
    Name = "jenkins_server"
  }
}

resource "aws_key_pair" "aws_kp" {
  key_name   = "aws_kp"
  public_key = file("${path.module}/aws_kp.pub")
}

# Creating an Elastic IP called jenkins_eip
resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_server.id
  vpc      = true

  tags = {
    Name = "jenkins_eip"
  }
}

provider "aws" {
  region = "eu-west-3"
}


resource "aws_key_pair" "deployer-key" {
  key_name      = "deployer-key"
  public_key    = file(var.ssh_key_path)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name      = "name"
    values    = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name      = "virtualization-type"
    values    = ["hvm"]
  }

  owners      = ["099720109477"] # Canonical
}


data "template_file" "userdata" {
  template = file("${path.module}/userdata.sh")
}

resource "aws_eip" "eip" {
  instance      = aws_instance.web.id
  vpc           = true
  tags          = {
    Name        = "${var.project_name}-web-epi"
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_http.id
  ]
  user_data = data.template_file.userdata.rendered
  key_name      = aws_key_pair.deployer-key.key_name
  tags          = {
    Name = "${var.project_name}-web-instance"
  }
}
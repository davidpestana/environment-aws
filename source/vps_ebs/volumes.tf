resource "aws_ebs_volume" "web" {
  availability_zone = var.availability_zone
  size              = 4
  type = "gp3"
  encrypted =   true
  tags = {
    Name = "${var.project_name}-web-ebs"
  }
}
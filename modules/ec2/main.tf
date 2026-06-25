resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  iam_instance_profile    = var.instance_profile_name
  key_name               = var.key_name

  tags = {
    Name        = "${var.project}-instance"
    Environment = var.environment
  }
}
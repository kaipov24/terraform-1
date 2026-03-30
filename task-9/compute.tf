resource "aws_instance" "main" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [data.aws_security_group.main.id]

  tags = {
    Name    = "${var.project_id}-instance"
    Project = var.project_id
  }
}
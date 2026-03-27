data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "epam-tf-practice" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  key_name               = aws_key_pair.epam-tf-practice.key_name
  subnet_id = "subnet-03f2bce0ce1686221"
  vpc_security_group_ids = ["sg-03168bcced6e3e6bb"]

  tags = {
    Name    = "cmtr-9upx8vyr-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-9upx8vyr"
  }
}

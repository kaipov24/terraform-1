resource "aws_key_pair" "epam-tf-practice" {
  key_name   = "cmtr-9upx8vyr-keypair"
  public_key = var.ssh_key
}
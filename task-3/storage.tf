resource "aws_s3_bucket" "epam-tf-practice" {
  bucket = var.bucket

  tags = {
    Project = var.project
  }
}

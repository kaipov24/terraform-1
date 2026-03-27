resource "aws_iam_group" "epam-tf-practice" {
  name = "cmtr-9upx8vyr-iam-group"
}

resource "aws_iam_policy" "epam-tf-practice" {
  name        = "cmtr-9upx8vyr-iam-policy"
  path        = "/"
  description = "My test policy"


  policy = templatefile("${path.module}/policy.json", {
    bucket_name = var.bucket
  })

  tags = {
    Project = "cmtr-9upx8vyr"
  }
}

resource "aws_iam_role" "epam-tf-practice" {
  name = "cmtr-9upx8vyr-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Project = "cmtr-9upx8vyr"
  }
}

resource "aws_iam_role_policy_attachment"  "epam-tf-practice" {
  role      = aws_iam_role.epam-tf-practice.name
  policy_arn = aws_iam_policy.epam-tf-practice.arn
}

resource "aws_iam_instance_profile" "epam-tf-practice" {
  name = "cmtr-9upx8vyr-iam-instance-profile"
  role = aws_iam_role.epam-tf-practice.name

  tags = {
    Project = "cmtr-9upx8vyr"
  }
}
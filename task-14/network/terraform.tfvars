aws_region = "us-east-1"

vpc_name               = "cmtr-9upx8vyr-vpc"
vpc_cidr               = "10.10.0.0/16"
internet_gateway_name  = "cmtr-9upx8vyr-igw"
route_table_name       = "cmtr-9upx8vyr-rt"

public_subnets = {
  public_a = {
    name              = "cmtr-9upx8vyr-subnet-public-a"
    cidr_block        = "10.10.1.0/24"
    availability_zone = "us-east-1a"
  }

  public_b = {
    name              = "cmtr-9upx8vyr-subnet-public-b"
    cidr_block        = "10.10.3.0/24"
    availability_zone = "us-east-1b"
  }

  public_c = {
    name              = "cmtr-9upx8vyr-subnet-public-c"
    cidr_block        = "10.10.5.0/24"
    availability_zone = "us-east-1c"
  }
}
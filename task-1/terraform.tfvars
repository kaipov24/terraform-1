aws_region       = "us-east-1"
vpc_name         = "cmtr-9upx8vyr-01-vpc"
vpc_cidr         = "10.10.0.0/16"
igw_name         = "cmtr-9upx8vyr-01-igw"
route_table_name = "cmtr-9upx8vyr-01-rt"

public_subnets = [
  {
    name              = "cmtr-9upx8vyr-01-subnet-public-a"
    cidr_block        = "10.10.1.0/24"
    availability_zone = "us-east-1a"
  },
  {
    name              = "cmtr-9upx8vyr-01-subnet-public-b"
    cidr_block        = "10.10.3.0/24"
    availability_zone = "us-east-1b"
  },
  {
    name              = "cmtr-9upx8vyr-01-subnet-public-c"
    cidr_block        = "10.10.5.0/24"
    availability_zone = "us-east-1c"
  }
]
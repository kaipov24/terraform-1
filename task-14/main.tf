provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"

  aws_region            = "us-east-1"
  vpc_name              = "cmtr-9upx8vyr-vpc"
  vpc_cidr              = "10.10.0.0/16"
  internet_gateway_name = "cmtr-9upx8vyr-igw"
  route_table_name      = "cmtr-9upx8vyr-rt"

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

  allowed_ip_range = var.allowed_ip_range
}

module "network_security" {
  aws_region = "us-east-1"
  source     = "./modules/network_security"

  vpc_id               = module.network.vpc_id
  allowed_ip_range     = var.allowed_ip_range
  ssh_sg_name          = "cmtr-9upx8vyr-ssh-sg"
  public_http_sg_name  = "cmtr-9upx8vyr-public-http-sg"
  private_http_sg_name = "cmtr-9upx8vyr-private-http-sg"
}

module "application" {
  aws_region = "us-east-1"
  source     = "./modules/application"

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.public_subnet_ids

  ssh_sg_id          = module.network_security.ssh_sg_id
  private_http_sg_id = module.network_security.private_http_sg_id
  public_http_sg_id  = module.network_security.public_http_sg_id

  launch_template_name = "cmtr-9upx8vyr-template"
  instance_type        = "t3.micro"

  asg_name         = "cmtr-9upx8vyr-asg"
  desired_capacity = 2
  min_size         = 2
  max_size         = 2

  lb_name = "cmtr-9upx8vyr-lb"
}
aws_region = "us-east-1"

launch_template_name      = "cmtr-9upx8vyr-template"
instance_type             = "t3.micro"
ssh_key_name              = "cmtr-9upx8vyr-keypair"
ami_id                    = "ami-09e6f87a47903347c"
iam_instance_profile_name = "cmtr-9upx8vyr-instance_profile"

metadata_http_endpoint = "enabled"

ec2_security_group_name  = "cmtr-9upx8vyr-ec2_sg"
http_security_group_name = "cmtr-9upx8vyr-http_sg"
alb_security_group_name  = "cmtr-9upx8vyr-sglb"

asg_name             = "cmtr-9upx8vyr-asg"
asg_desired_capacity = 2
asg_min_size         = 1
asg_max_size         = 2

alb_name              = "cmtr-9upx8vyr-loadbalancer"
alb_listener_port     = 80
alb_listener_protocol = "HTTP"

project_tag           = "cmtr-9upx8vyr"
terraform_tag         = "true"
metadata_http_tokens  = "optional"
vpc_id                = "cmtr-9upx8vyr-vpc"
public_subnet_cidr_a  = "10.0.1.0/24"
private_subnet_cidr_a = "10.0.2.0/24"
public_subnet_cidr_b  = "10.0.3.0/24"
private_subnet_cidr_b = "10.0.4.0/24"
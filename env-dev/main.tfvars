env = "dev"
instance_type = "t3.small"
zone_id = "Z03351562OJATKDWYEO40"


# vpc
vpc_cidr_block          = "10.0.0.0/24"
default_vpc_cidr_block  = "172.31.0.0/16"
default_vpc_id          = "vpc-05f40aba9acea42ad"
default_rt_ID           = "rtb-01567f39cdb5fdfee"
frontend_subnets        = ["10.0.0.0/27", "10.0.0.32/27"]
backend_subnets         = ["10.0.0.64/27","10.0.0.96/27"]
db_subnets              = ["10.0.0.128/27", "10.0.0.160/27"]
Availability_zones      = ["us-east-1a", "us-east-1b"]

region     = "us-east-1"
vpc_cidr   = "10.0.0.0/16"
route_cidr = "0.0.0.0/0"

subnets = {
  "public-1" = {
    cidr   = "10.0.1.0/24"
    az     = "us-east-1a"
    public = true
  },
  "public-2" = {
    cidr   = "10.0.2.0/24"
    az     = "us-east-1b"
    public = true
  },
  "private-1" = {
    cidr   = "10.0.3.0/24"
    az     = "us-east-1a"
    public = false
  },
  "private-2" = {
    cidr   = "10.0.4.0/24"
    az     = "us-east-1b"
    public = false
  }
}

instance_type    = "t2.micro"
min_size         = 2
max_size         = 4
desired_capacity = 2
volume_size = 10


variable "region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "route_cidr" {
  type = string
}

variable "subnets" {
  type = map(object({
    cidr   = string
    az     = string
    public = bool
  }))
}


variable "instance_type" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "volume_size" {
  type = number
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair"
  type        = string
}


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

variable "instance_profile_name" {
  type        = string
  description = "Name of the existing IAM instance profile"
  default     = "AdminSSMRole"
}

variable "key_name" {
  type        = string
  description = "Name of the existing key pair"
  default     = "CloudTechv1"
}

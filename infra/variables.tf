variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "my_ip" {
  description = "My IP address"
  type        = string
  sensitive   = true
}

variable "docker_registry_password" {
  type = string
  sensitive = true
  description = "Docker registry password"
}

variable "docker_registry_username" {
  description = "Docker registry username"
  type = string
  default = "sverh123"
}
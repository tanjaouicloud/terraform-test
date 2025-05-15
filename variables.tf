variable "region" {
  description = "VPC Region"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr_block" {
  description = "Public Subnet 1 CIDR"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr_block" {
  description = "Public Subnet 2 CIDR"
  default     = "10.0.2.0/24"
}

variable "private_subnet1_cidr_block" {
  description = "Private Subnet 1 CIDR"
  default     = "10.0.3.0/24"
}

variable "private_subnet2_cidr_block" {
  description = "Private Subnet 2 CIDR"
  default     = "10.0.4.0/24"
}

variable "public_subnet1_az" {
  description = "Public Subnet 1 Availability Zone"
  default     = "us-east-1a"
}

variable "public_subnet2_az" {
  description = "Public Subnet 2 Availability Zone"
  default     = "us-east-1b"
}


variable "private_subnet1_az" {
  description = "Private Subnet 1 Availability Zone"
  default     = "us-east-1c"
}

variable "private_subnet2_az" {
  description = "Private Subnet 2 Availability Zone"
  default     = "us-east-1d"
}


variable "ami" {
  description = "Amazon Linux Image"
  default     = "ami-0953476d60561c955"
}

variable "instance_type" {
  description = "Server Instance Type"
  default     = "t2.micro"
}

variable "engine" {
  description = "RDS Engine"
  default     = "mysql"
}

variable "db_name" {
  description = "Database Name"
  default     = "mydb"
}

variable "db_username" {
  description = "Database Username"
  default     = "admin123"
}

variable "db_password" {
  description = "Database Password"
  default     = "Mydb123#"
}

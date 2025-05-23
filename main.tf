provider "aws" {
  region = var.region
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_subnet" "public-subnet1" {
  cidr_block        = var.public_subnet1_cidr_block
  vpc_id            = aws_vpc.default.id
  availability_zone = var.public_subnet1_az

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_subnet" "public-subnet2" {
  cidr_block        = var.public_subnet2_cidr_block
  vpc_id            = aws_vpc.default.id
  availability_zone = var.public_subnet2_az

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_subnet" "private-subnet1" {
  cidr_block        = var.private_subnet1_cidr_block
  vpc_id            = aws_vpc.default.id
  availability_zone = var.private_subnet1_az

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_subnet" "private-subnet2" {
  cidr_block        = var.private_subnet2_cidr_block
  vpc_id            = aws_vpc.default.id
  availability_zone = var.private_subnet2_az

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_route_table_association" "rt-asso-public-subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.default.id
}

resource "aws_route_table_association" "rt-asso-public-subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.default.id
}

resource "aws_security_group" "wpsg" {
  name        = "wpsg"
  description = "Allow Incoming HTTP traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_security_group" "elbsg" {
  name        = "elbsg"
  description = "Allow Incoming HTTP traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_security_group" "dbsg" {
  name        = "dbsg"
  description = "Allow access to MySQL from WP"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.wpsg.id}"]
  }

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "blogkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJzlxMyZjLQw/XOSjOKJunv8Pa72xoK3X/MAJKkZRtcaxXpOVkYLktk6NpU62iQ/H78LCo5RJCR7dxz+nZhRCaIvDIYZaAK84K0bIvOSCqt4t9juEimRX1j8gy3UTxh0hG9WwaJGrhc+zjxW5GtLlm1puBK7Ftz8hfbrOXoy7TITeHetEl58UN15LEBsh3CebOzEnN/3fqbG8ccbUzspD8OKxOb378PiXDfsHUEF7ORPOoh5KMnewpywKEap2XuLJezWepl5Aj56kmDnfGv6wgQkXtUeADHEpoUGiCqww3+k5jYcpz0pgWqZkRmAF4CuyhLBryxwoX6qzgcPGTcPHR fahd@DESKTOP-J0RSHTA"
}

resource "aws_instance" "wb1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.default.id
  user_data                   = file("bootstrap.sh")
  vpc_security_group_ids      = ["${aws_security_group.wpsg.id}"]
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_instance" "wb2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.default.id
  user_data                   = file("bootstrap.sh")
  vpc_security_group_ids      = ["${aws_security_group.wpsg.id}"]
  subnet_id                   = aws_subnet.public-subnet2.id
  associate_public_ip_address = true

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_db_subnet_group" "default" {
  name        = "db-subnet-group"
  description = "RDS Subnet Group"
  subnet_ids  = ["${aws_subnet.private-subnet1.id}", "${aws_subnet.private-subnet2.id}"]

  tags = {
    Environment = "Development"
    Owner       = "Luke Skywalker"
    Department  = "Jedi Order"
  }
}

resource "aws_db_instance" "default" {

  engine                 = var.engine
  engine_version         = "8.0.34"
  storage_type           = "gp2"
  allocated_storage      = 5
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = ["${aws_security_group.dbsg.id}"]
  db_subnet_group_name   = aws_db_subnet_group.default.id
}

resource "aws_elb" "default" {
  name                        = "elbwp"
  instances                   = ["${aws_instance.wb1.id}", "${aws_instance.wb2.id}"]
  subnets                     = ["${aws_subnet.public-subnet1.id}", "${aws_subnet.public-subnet2.id}"]
  security_groups             = ["${aws_security_group.elbsg.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

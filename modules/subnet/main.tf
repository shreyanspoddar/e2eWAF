# module "vpc" {
#   source = "../vpc"
# }
resource "aws_subnet" "Websubnet-1" {
  vpc_id                  = var.vpcid
  cidr_block             = var.subnet1
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"

  tags = {
    Name = "Subnet 1"
  }
}

resource "aws_subnet" "Websubnet-2" {
  vpc_id                  = var.vpcid
  cidr_block             = var.subnet2
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"

  tags = {
    Name = "Subnet 2"
  }
}

resource "aws_subnet" "DatabaseSubnet-1" {
  vpc_id                  = var.vpcid
  cidr_block             = var.subnet3
  availability_zone = "us-east-2a"

  tags = {
    Name = "Database Subnet 1"
  }
}


resource "aws_subnet" "DatabaseSubnet-2" {
  vpc_id                  = var.vpcid
  cidr_block             = var.subnet4
  availability_zone = "us-east-2b"

  tags = {
    Name = "Database Subnet 2"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpcid
}
resource "aws_route_table" "route" {
    vpc_id = var.vpcid

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = {
        Name = "Route to internet"
    }
}

# Associating Route Table
resource "aws_route_table_association" "rt1" {
    subnet_id = "${aws_subnet.Websubnet-1.id}"
    route_table_id = "${aws_route_table.route.id}"
}

# Associating Route Table
resource "aws_route_table_association" "rt2" {
    subnet_id = "${aws_subnet.Websubnet-2.id}"
    route_table_id = "${aws_route_table.route.id}"
}
resource "aws_security_group" "websg" {
  vpc_id = var.vpcid
 
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  tags = {
    Name = "Web SG"
  }
}
resource "aws_vpc" "ProjectVpc" {
  cidr_block       = var.cidrblock
  instance_tenancy = "default"

  tags = {
    Name = "Project VPC"
  }
}

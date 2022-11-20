# module "vpc" {
#   source = "../vpc"
# }
# module "subnet" {
#   source = "../subnet"
# }
resource "aws_security_group" "db-sg" {
  name        = "Database SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = var.vpcid

  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.sgid
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database SG"
  }
}
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.databasesubnetid

  tags = {
    Name = "Database subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  multi_az               = true
  name                   = "mydb"
  username               = "ProjectTtn"
  password               = "Project123"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db-sg.id]
}
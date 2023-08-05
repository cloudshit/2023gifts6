resource "aws_security_group" "db" {
  name        = "skills-sg-db"
  description = "Allow database traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_db_subnet_group" "db" {
  name = "skills-db-subnets"
  subnet_ids = [
    aws_subnet.protected_a.id,
    aws_subnet.protected_b.id,
    aws_subnet.protected_c.id
  ]
}

resource "aws_rds_cluster" "db" {
  cluster_identifier          = "skills-db"
  database_name               = "dev"
  availability_zones        = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  db_subnet_group_name = aws_db_subnet_group.db.name
  master_username             = "skills"
  manage_master_user_password = true
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot = true
  engine = "aurora-postgresql"
  engine_version = "14.6"
}

resource "aws_rds_cluster_instance" "db" {
  count = 3
  cluster_identifier = aws_rds_cluster.db.id
  instance_class         = "db.r6g.large"
  identifier             = "skills-db-${count.index}"
  engine = "aurora-postgresql"
}

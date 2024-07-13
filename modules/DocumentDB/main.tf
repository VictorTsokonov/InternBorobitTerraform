resource "aws_docdb_cluster" "default" {
  cluster_identifier = "my-docdb-cluster"
  master_username    = var.db_username
  master_password    = var.db_password
  engine_version     = "4.0.0"
  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name = aws_docdb_subnet_group.default.name
  skip_final_snapshot = true

  tags = {
    Name = "my-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "default" {
  count              = 1
  identifier         = "my-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.default.id
  instance_class     = "db.r5.large"

  tags = {
    Name = "my-docdb-instance-${count.index}"
  }
}

resource "aws_docdb_subnet_group" "default" {
  name       = "my-docdb-subnet-group"
  subnet_ids = var.public_subnets

  tags = {
    Name = "my-docdb-subnet-group"
  }
}

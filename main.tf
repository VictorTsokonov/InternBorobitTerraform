module "network" {
  source = "./modules/network"

  azs         = var.azs
  vpc_cidr    = var.vpc_cidr
  public_subnets = var.public_subnets
}

module "documentdb" {
  source = "./modules/DocumentDB"

  db_username            = var.db_username
  db_password            = var.db_password
  public_subnets         = module.network.public_subnets
  security_group_id      = module.network.security_group_id
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = module.network.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}

resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name
  subnet_id     = module.network.public_subnets[0]
  security_groups = [aws_security_group.bastion_sg.id]

  user_data = templatefile("${path.module}/scripts/install_dep.sh.tmpl", {
    DB_USER     = var.db_username
    DB_PASSWORD = var.db_password
    DB_HOST     = module.documentdb.docdb_endpoint
    DB_NAME     = "InternBorobit"
  })

  depends_on = [ module.documentdb ]

  tags = {
    Name = "bastion-host"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "docdb_endpoint" {
  value = module.documentdb.docdb_endpoint
}

output "user_data_ec2" {
  value = nonsensitive(aws_instance.bastion.user_data)
}
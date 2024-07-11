terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.InternBorobit.id // Name of S3 Bucket
    key            = "terraform.tfstate"
    dynamodb_table = aws_dynamodb_table.terraform_locks.id // Name of DynamoDB
  }
}

resource "aws_s3_bucket" "InternBorobit" {
  bucket = "InternBorobitTerraformState"
#   lifecycle {
#     prevent_destroy = true
#   }
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.InternBorobit.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "simple" {
  bucket = aws_s3_bucket.InternBorobit.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "InternBorobitTfLockTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "string"
  }

#   lifecycle {
#     prevent_destroy = true
#   }

  tags = {
    "Team" = "TUES",
    "ProducedBy" = "Terraform"
  }
}

terraform {
  backend "s3" {
    region = "eu-central-1"
    bucket         = "intern-borobit-tf-state" // Name of S3 Bucket for .tfstate + versioning 
    key            = "terraform.tfstate"
    dynamodb_table = "InternBorobitTfLockTable" // Name of DynamoDB for State Lock
    
  }
}

resource "aws_s3_bucket" "InternBorobit" {
  bucket = "intern-borobit-tf-state"
  
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    "Team" = "TUES",
    "ProducedBy" = "Terraform"
  }
}



resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.InternBorobit.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
  
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.InternBorobit.id
  rule {
    object_ownership = "ObjectWriter"
  }
  
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
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    "Team" = "TUES",
    "ProducedBy" = "Terraform"
  }
}

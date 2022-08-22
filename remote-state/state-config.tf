resource "aws_s3_bucket" "terraform_state" {
  bucket = "oc-terraform-running-state"
  }

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "oc-terraform-running-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
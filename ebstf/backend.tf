terraform {
  backend "s3" {
      bucket                = "oc-terraform-running-state"
      key                   = "global/s3/terraform.tfstate"
      region                = "us-east-1"

      dynamodb_table        = "oc-terraform-running-state-locks"
      encrypt               = true
  }
}
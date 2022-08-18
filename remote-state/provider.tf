provider "aws" {
    region = "us-east-1"
    default_tags {
      tags = {
          Environment = "Lab"
          Function = "Testing"
      }
    }
}

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.8.0"
        }
    }
}
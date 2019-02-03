provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-up-n-running-state"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }
}
terraform {
  backend "s3" {
    bucket  = "terraform-up-n-running-state"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true    
    dynamodb_table = "tfstate_table"
  }
}

output "s3_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state.arn}"
}

provider "aws" {
  region  = var.AWS_REGION
}

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      version = "~> 4"
    }
    null = {
      version = "~> 3"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "s3-bucket" # make sure bucket and dynamo are in same region if dynamo code used
    key    = "terraform.tfstate"
    region = "us-xxx-2" # enter actual region
    dynamodb_table = "dynamo-table" # uJst add if needed, if not just remove this line, yManual
  }
}

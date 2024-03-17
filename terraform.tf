provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "hashicode-tf"
    key     = "hashicode.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "default"
  }
}

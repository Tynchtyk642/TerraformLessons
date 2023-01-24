terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.51.0"
    }
  }

  backend "s3" {
    bucket = "terraform-tfstate-sfjfljsdlfdsjf"
    key    = "imgragim/dev.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "arstan"
  region = "us-west-1"
}


variable "acm_domain" {
  description = "The domain of the certificate to look up. If no certificate is found with this name, an error will be returned."
  type        = string
}
data "aws_region" "selected" {}

data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu_1804" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/*/ubuntu-bionic-18.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}
data "aws_caller_identity" "current" {}

data "aws_cloudfront_origin_request_policy" "managed_cors_s3origin" {
  name = "Managed-CORS-S3Origin"
}

//data "aws_cloudfront_cache_policy" "managed_cache_optimized" {
//  name = "project-name-CachingOptimized"
//}

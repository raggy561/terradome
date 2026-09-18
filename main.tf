terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.64.0"
    }
  }
  required_version = ">=1.12.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr= var.vpc_cidr

  azs             = ["us-west-2a", "us-west-2b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false # DO NOT WANT TO GET CHARGED - LEFT OFF
  create_igw = true
  

  tags = {
    Project = var.project_name
    Environment = var.environment
  }

}

resource "aws_security_group" "instance" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Deny-by-default; SSH from my IP only"
  vpc_id      = module.vpc.vpc_id          

  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]            
  }
}

/*module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.4"
  
  bucket = "terradome-dev-hjean-2026"
  acl = "private"

  control_object_ownership = true
  object_ownership ="BucketOwnerEnforced"

  versioning = {
    enabled = true
  }

}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"

  name = "aws-terradome"
  
  ami = data.aws_ami.ubuntu.id # < Canonical lookup  
  instance_type = var.instance_type
  monitoring = true
  root_block_device = { encrypted = true }
  vpc_security_group_ids = [instance]
  subnet_id = module.vpc.public_subnets[0]

}

data "aws_ami" "ubuntu" {
most_recent = true
owners = ["099720109477"] 

filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

filter {
  name = "virtualization-type"
  values = ["hvm"]
    }
}
*/
/*
# Log bucket — name must be globally unique, so append the account ID
resource "aws_s3_bucket" "trail" {
  bucket        = "${var.project_name}-${var.environment}-cloudtrail-${data.aws_caller_identity.current.account_id}"
  force_destroy = true   # lab convenience — lets destroy empty it

  tags = {
    Name = "${var.project_name}-${var.environment}-cloudtrail"
  }
}

# Secure baseline — same controls as your other buckets
resource "aws_s3_bucket_public_access_block" "trail" {
  bucket                  = aws_s3_bucket.trail.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "trail" {
  bucket = aws_s3_bucket.trail.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bucket policy — lets CloudTrail check ACL and write objects
data "aws_iam_policy_document" "trail" {
  statement {
    sid     = "AWSCloudTrailAclCheck"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [aws_s3_bucket.trail.arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${var.project_name}-${var.environment}-trail"]
    }
  }

  statement {
    sid     = "AWSCloudTrailWrite"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["${aws_s3_bucket.trail.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${var.project_name}-${var.environment}-trail"]
    }
  }
}

resource "aws_s3_bucket_policy" "trail" {
  bucket = aws_s3_bucket.trail.id
  policy = data.aws_iam_policy_document.trail.json
}

# The trail itself
resource "aws_cloudtrail" "main" {
  depends_on = [aws_s3_bucket_policy.trail]

  name                          = "${var.project_name}-${var.environment}-trail"
  s3_bucket_name                = aws_s3_bucket.trail.id
  include_global_service_events = true    # capture IAM, STS, etc.
  is_multi_region_trail         = true    # best-practice for a landing zone
  enable_log_file_validation    = true    # tamper-detection on the logs
}

# These data sources you already have — don't duplicate them
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}
*/
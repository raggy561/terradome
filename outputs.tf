output "vpc_id" {
  description = "ID of Terradome VPC"
  value = module.vpc.vpc_id
}

output "security_group_id" {
  description = "ID of the deny-by-default security group"
  value       = aws_security_group.instance.id
}

output "cloudtrail_bucket" {
  description = "Name of the CloudTrail log bucket"
  value       = aws_s3_bucket.trail.id
}
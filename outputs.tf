// Line to add in terraform cli to init backend
output "backend_config_cli_string" {
  value = "-backend-config='bucket=${var.bucket_tfstates_name}' -backend-config='region=${var.deploy_region}' -backend-config='encrypt=true' -backend-config='kms_key_id=${aws_kms_key.kms_tfstates.arn}' -backend-config='dynamodb_table=${aws_dynamodb_table.dynamodb_tfstates.name}'"
}

// Map to add in your backend configuration
output "backend_config_map" {
  value = {
    bucket         = "${var.bucket_tfstates_name}"
    region         = "${var.deploy_region}"
    encrypt        = "true"
    kms_key_id     = "${aws_kms_key.kms_tfstates.arn}"
    dynamodb_table = "${aws_dynamodb_table.dynamodb_tfstates.name}"
  }
}

// ARN of the produced kms key for users' grants
output "kms_tfstates" {
  value = "${aws_kms_key.kms_tfstates.arn}"
}

// ARN of the created s3 bucket for usage in policies
output "s3_tfstates" {
  value = "${aws_s3_bucket.bucket_tfstates.arn}"
}

// ARN of the dynamodb table created
output "dynamodb_tfstates" {
  value = "${aws_dynamodb_table.dynamodb_tfstates.arn}"
}
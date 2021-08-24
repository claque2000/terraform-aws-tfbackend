// Name of the s3 bucket
variable "bucket_tfstates_name" {
  type = string
}

// Region where the objects will be deployed
variable "deploy_region" {
  type = string
}

// List of infrastructure administrators
variable "administrators" {
  type = list(any)
}

// List of Terraform users
variable "users" {
  type = list(any)
}

// Tags to apply on s3_bucket
variable "tags" {
  type = map(any)
}

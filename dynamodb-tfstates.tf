resource "aws_dynamodb_table" "dynamodb_tfstates" {
  name           = "${var.bucket_tfstates_name}-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  tags = "${merge(
    map("Name", format("%s", "${var.bucket_tfstates_name}-lock")),
    var.tags
  )}"

  attribute {
    name = "LockID"
    type = "S"
  }
}

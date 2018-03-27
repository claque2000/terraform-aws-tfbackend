resource "aws_s3_bucket" "bucket_tfstates" {
  bucket = "${var.bucket_tfstates_name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  force_destroy = true

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.kms_tfstates.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  policy = "${data.aws_iam_policy_document.bucket_tfstates_policy.json}"

  tags = "${merge(
    map("Name", var.bucket_tfstates_name),
    var.tags
  )}"

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "bucket_tfstates_policy" {
  statement {
    sid    = "Admins can do everything"
    effect = "Allow"

    principals {
      identifiers = "${var.administrators}"
      type        = "AWS"
    }

    actions = [
      "s3:DeleteBucket",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_tfstates_name}",
      "arn:aws:s3:::${var.bucket_tfstates_name}/*",
    ]
  }

  statement {
    sid    = "Users can run Terraform"
    effect = "Allow"

    principals {
      identifiers = "${var.users}"
      type        = "AWS"
    }

    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_tfstates_name}",
      "arn:aws:s3:::${var.bucket_tfstates_name}/*",
    ]
  }

  statement {
    sid    = "Deny unencrypted object upload"
    effect = "Deny"

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_tfstates_name}/*"]

    condition {
      test     = "StringNotEquals"
      values   = ["aws:kms"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }
}

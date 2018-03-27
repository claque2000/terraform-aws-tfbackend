resource "aws_kms_key" "kms_tfstates" {
  description = "Terraform tfstates bucket encryption key"
  policy      = "${data.aws_iam_policy_document.kms_tfstate_policy.json}"

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "kms_tfstate_policy" {
  statement {
    sid = "Allow access for Key Administrators"

    principals {
      type        = "AWS"
      identifiers = "${var.administrators}"
    }

    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    resources = ["*"]
  }

  statement {
    sid = "Allow use of the key"

    principals {
      type        = "AWS"
      identifiers = "${var.administrators}"
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
      "kms:List*",
    ]

    resources = ["*"]
  }
}

resource "aws_kms_alias" "tfstates" {
  name          = "alias/${var.bucket_tfstates_name}"
  target_key_id = "${aws_kms_key.kms_tfstates.key_id}"
}

# Module to create tfstate backend
## Why ?
As you should know, you can use s3 as backend for your tfstates. That's great but there is some more features availables:
* s3 encryption with kms for securing your tfstates at rest
* dynamodb lock to ensure non parallel execution of the same stack
But it can be quite annoying to create it at each new project. So, this module was created to fullfil this need.

## What is included ?
This modules will create all the necessary pieces you need to have all those features (assuming you have an admin and a user or more with whole access to bucket):
* a kms key where:
 * the admin can update the key policy
 * the user can use the key to encrypt/decrypt data
* an s3 bucket:
 * with write access for users
 * denying unencrypted uploads
* a dynamodb table which will be used to lock multiple deployments

Differents outputs are available from this module:
* the cli arguments to use during terraform init
* the configuration to add in your backend section

## How to use it ?
See [Usage](docs/usage.md).

You will also need to add policy statement for kms usage to your users, using the KMS key arn given in module output:
```
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      "Resource": output kms arn
    }
```
You need also to grant access to the dynamodb table:
```
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": output dynamodb arn
    }
```

## We love OSS
This module is distributed under [MIT License](https://opensource.org/licenses/MIT).

The usage documentation was created using [Terraform-docs](https://github.com/segmentio/terraform-docs)


Thanks to [Aurélien Maury](https://github.com/aurelienmaury) for his code review

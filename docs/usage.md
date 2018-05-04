Module usage:

     module "tfbackend" {
       source               = "github.com/claque2000/mod_tfbackend"
       deploy_region        = "eu-west-3"
       bucket_tfstates_name = "terraform-tfstates"
       administrators       = ["arn:aws:iam::123456789012:user/admin"]
       users                = ["arn:aws:iam::123456789012:role/builder","arn:aws:iam::123456789012:user/dev_x"]  

      tags {
        Name    = "TerrifEric One"
        Env     = "Test"
        Billing = "Someone Else"
      }
    }



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| administrators | List of infrastructure administrators | list | - | yes |
| bucket_tfstates_name | Name of the s3 bucket | string | - | yes |
| deploy_region | Region where the objects will be deployed | string | - | yes |
| tags | Tags to apply on s3_bucket | map | - | yes |
| users | List of Terraform users | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| backend_config_cli_string | Line to add in terraform cli to init backend |
| backend_config_map | Map to add in your backend configuration |
| dynamodb_tfstates | ARN of the dynamodb table created |
| kms_tfstates | ARN of the produced kms key for users' grants |
| s3_tfstates | ARN of the created s3 bucket for usage in policies |


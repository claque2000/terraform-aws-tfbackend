/**
 * Module usage:
 *
 *      module "tfbackend" {
 *        source               = "github.com/claque2000/mod_tfbackend"
 *        deploy_region        = "eu-west-3"
 *        tfstates_bucket_name = "terraform-tfstates"
 *        administrators       = ["arn:aws:iam::123456789012:user/admin"]
 *        users                = ["arn:aws:iam::123456789012:role/builder","arn:aws:iam::123456789012:user/dev_x"]
 *      }
 *
 */


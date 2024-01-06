
terraform {
  backend "s3" {
    bucket     = "mudivili-terraform-state-bucket"
    key        = "administrator-user/terraform.tfstate"
    region     = "ap-south-1"
    encrypt    = true
    kms_key_id = "alias/terraform-state-bucket-key"
  }
}

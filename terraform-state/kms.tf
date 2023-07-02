resource "aws_kms_key" "terraform-state-bucket-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
  name          = "alias/terraform-state-bucket-key"
  target_key_id = aws_kms_key.terraform-state-bucket-key.key_id
}

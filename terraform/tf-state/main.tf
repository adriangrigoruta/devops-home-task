### This is a terraform pre-req that we have to do in 2 steps:
### step 1: create this S3 bucket used for tf state
### step 2: migrate the existing state by uncommenting the S3 backend and re-running tf init

module "s3_bucket" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "v4.8.0"
  bucket                  = "${var.project}-${var.application}"
  acl                     = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

}

resource "aws_dynamodb_table" "dynamodb-tf-state-lock" {
  name = "${var.project}-${var.application}-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
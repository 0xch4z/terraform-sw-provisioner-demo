provider "aws" {
  secret_key = "${var.AWS_SECRET_KEY}"
  access_key = "${var.AWS_ACCESS_KEY}"
  region     = "${var.AWS_REGION}"
}

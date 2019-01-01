terraform {
  backend "s3" {
    bucket = "terraform-state-tswpd"
    key    = "terraform/sw-provisioner-demo"
  }
}

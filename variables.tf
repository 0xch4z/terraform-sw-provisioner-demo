variable "AWS_SECRET_KEY" { }

variable "AWS_ACCESS_KEY" { }

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PUBLIC_KEY_PATH" {
  default = "~/.ssh/id_rsa.pub"
}

variable "PRIVATE_KEY_PATH" {
  default = "~/.ssh/id_rsa"
}

terraform {
  backend "s3" {
    bucket  = "terraform-state-luizmota"
    key     = "site/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
    use_lockfile = true
  }
}

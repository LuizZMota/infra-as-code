resource "aws_ecr_repository" "ecr-site" {

  name                 = "site-prod"
  image_tag_mutability = "MUTABLE"

}
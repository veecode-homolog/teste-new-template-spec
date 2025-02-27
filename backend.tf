terraform {
  backend "s3" {
    bucket         = "veecode-homolog-iac-terraform-remote-state"
    key            = "teste-new-spec-template"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "veecode-homolog-iac-terraform-remote-state.tfstate"
  }
}

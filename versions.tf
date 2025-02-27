terraform {
  required_version = "1.10.3" #ùltima versão no dia 19-12-2024

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80.0" #ùltima versão no dia 12-12-2024
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

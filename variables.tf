variable "project_name" {
  description = "A chave superior para ser usada nas variáveis de resource_tags e node_groups"
  type        = string
  default     = "iac-terraform-ec2"
}

variable "aws_region" {
  description = "The AWS region your resources will be deployed"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key ID."
  sensitive   = true
  type        = string
  default     = null
}

variable "aws_secret_key" {
  description = "AWS Access Secret Key."
  sensitive   = true
  type        = string
  default     = null
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
    Name        = "veecode-dev"
  }
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t4g.medium"
}

variable "keypair_name" {
  description = "The name of the keypair to use for the instance"
  type        = string
}

variable "volume_type" {
  description = "The type of volume to create"
  type        = string
  default     = "gp3"
}

variable "volume_size" {
  description = "The size of the volume to create"
  type        = number
  default     = 30
}

variable "ansible_ssh_private_key_file" {
  description = "The path to the private key file to use for SSH connections"
  type        = string
  default     = null
}

variable "ansible_user" {
  description = "The user to use for SSH connections"
  type        = string
  default     = "ec2-user"
}

variable "ansible_playbook" {
  description = "The path to the Ansible playbook to run"
  type        = string
}

variable "host_name" {
  description = "The domain name to use for the Route53 zone"
  type        = string
  default     = "veecode.com"
}

variable "ansible_vault" {
  description = "The path to the Ansible vault file"
  type        = string
  default     = "./vault.yml"
}

variable "ansible_vault_password_file" {
  description = "The path to the Ansible vault password file"
  type        = string
  default     = "./.vault_pass.txt"
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "veecode-instance"
}
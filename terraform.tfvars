# aws variables
aws_region = "us-east-1"
resource_tags = {
  Environment = "homolog"
    Terraform   = "true"
    Name        = "veecode-homolog-vpc"

}

# ec2 variables
instance_type = "t4g.medium"
keypair_name  = "platform_kp"
# volume_type   = "gp3"
# volume_size   = 30

# ansible variables
ansible_ssh_private_key_file = "./cert.pem"
ansible_user                 = "ec2-user"
ansible_playbook             = "./playbook.yml"

ansible_vault                = "./vault.yml"
ansible_vault_password_file  = "./.vault_pass.txt" 

# proxy variables
host_name = "teste.platform.vee.codes"

instance_name = "teste-new-template-spec"
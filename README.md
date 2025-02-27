# EC2 K3s Ansible - Generated Repository

This repository was automatically generated from the **EC2 K3s Ansible Template** in Backstage. It contains the necessary files for provisioning and configuring a **K3s** cluster on an **AWS EC2** instance using **Terraform** and **Ansible**.

## Repository Structure

```
.
├── .github/workflows/      # CI/CD workflows for provisioning
├── .platform/              # Backstage integration metadata
├── playbook.yml            # Ansible playbook for instance configuration
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Terraform variables definition
├── backend.tf              # Remote backend configuration for Terraform
├── data.tf                 # AWS resources import
├── providers.tf            # AWS provider configuration
├── vault.yml               # Credentials and secrets needed for configuration
└── README.md               # Repository-specific documentation
```

## Requirements
Before starting the deployment, ensure you have:
- **AWS CLI** configured with appropriate credentials
- **Terraform** version `1.10.3` or higher
- **Ansible** installed on your local machine
- **Valid SSH key pair** for accessing the EC2 instance

## Configuration and Deployment

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Validate Configuration
```bash
terraform plan
```

### 3. Apply Infrastructure
```bash
terraform apply --auto-approve
```

### 4. Configure Instance via Ansible
After the EC2 instance is created, run the following command:
```bash
ansible-playbook -i <INSTANCE_IP>, playbook.yml --private-key <SSH_KEY_PATH>
```

## GitHub Actions Credentials Configuration
GitHub Actions workflows depend on credentials to access AWS and the repository. To ensure automation works correctly, follow these steps:

1. In the GitHub repository, go to **Settings > Secrets and variables > Actions**.
2. Add the following secrets:
    - `AWS_ACCESS_KEY_ID`: AWS access key.
    - `AWS_SECRET_ACCESS_KEY`: AWS secret key.
    - `AWS_REGION`: AWS region for resources.
    - `KEYPAIR`: Private key used for SSH connection.
    - `ANSIBLE_VAULT_PASSWORD`: Password used for Ansible Vault encryption.
3. These secrets are automatically used by the workflows in `.github/workflows/deploy.yml` and `.github/workflows/destroy.yml`.
4. To check the workflow execution, go to the **Actions** tab in the repository.

## Ansible Vault Configuration
To securely store sensitive data, use Ansible Vault for encryption.

1. Create a vault password file:
   ```bash
   echo "your-secret-password" > .vault_pass
   ```
2. Encrypt variables file:
   ```bash
   ansible-vault encrypt vault.yml --vault-password-file .vault_pass
   ```
3. Decrypt when needed:
   ```bash
   ansible-vault decrypt vault.yml --vault-password-file .vault_pass
   ```

GitHub Actions automatically loads `ANSIBLE_VAULT_PASSWORD` for decryption during workflow execution.

## Outputs
After execution, the following resources will be available:
- **EC2 instance IP address**
- **Access to the K3s cluster** via `kubectl`
- **Ingress configured with Kong**
- **Configured PostgreSQL database**

## Example of Connecting to the Cluster
Configure `kubectl` to access the generated cluster:
```bash
scp -i <SSH_KEY_PATH> ec2-user@<INSTANCE_IP>:/home/ec2-user/.kube/config ~/.kube/config
kubectl get nodes
```


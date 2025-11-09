# Azure Terraform Lab

## Project Structure
```
.
├── env/
│   ├── dev.tfvars
│   └── prod.tfvars
├── main.tf           # Main Terraform configuration
├── variables.tf      # Variable declarations
├── versions.tf       # Provider and Terraform version requirements
└── terraform.tfvars  # Default variable values
```

## Setup

1. **Azure Authentication**
   ```bash
   az login
   az account show  # Verify your active subscription
   az account list # List all subscriptions
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   terraform init -upgrade # Upgrade providers to latest version
   ```

3. **Environment Configuration**
   - Default variables are set in `terraform.tfvars`
   - Environment-specific overrides are in `env/` directory
   - Current default application name: `deva`
   - Primary location: `eastus`
   - Subscription ID: `az account show --query id -o tsv`
   - set Subscription ID BASH: `export ARM_SUBSCRIPTION_ID="<subscription_id>"`
   - set Subscription ID POWERSHELL: `$env:ARM_SUBSCRIPTION_ID = "<subscription_id>"`

4. **Deployment**
   - For development environment:
     ```bash
     terraform plan -var-file=env/dev.tfvars
     terraform apply -var-file=env/dev.tfvars
     ```
   - For production environment:
     ```bash
     terraform plan -var-file=env/prod.tfvars
     terraform apply -var-file=env/prod.tfvars
     ```

## Resources
- Creates an Azure Resource Group with naming convention: `rg-{application_name}-{environment_name}`
- Configured for multi-environment deployment (dev/prod)
- Uses AzureRM provider (v4.52.0)

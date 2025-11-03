# Lab1 Commands

## Tools setup

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco
choco install terraform -y
terraform -v
choco install azure-cli -y
choco install git -y
```

## Terraform workflow

```powershell
terraform init
terraform plan
terraform apply
terraform destroy

# outputs
terraform output "application_name"

# with inline variables
terraform plan -var "application_name=dev" -var "environment=prod"
terraform apply -var "application_name=dev" -var "environment=prod"

# using var-files (env)
terraform plan -var-file .\env\dev.tfvars
terraform apply -var-file .\env\dev.tfvars
terraform plan -var-file .\env\prod.tfvars
terraform apply -var-file .\env\prod.tfvars
```

## Repository setup

```powershell
git init
```

## Terraform workspaces used

```powershell
terraform workspace list
terraform workspace new dev
terraform plan -var-file .\env\dev.tfvars
terraform apply -var-file .\env\dev.tfvars
terraform workspace new prod
terraform plan -var-file .\env\prod.tfvars
terraform apply -var-file .\env\prod.tfvars
terraform workspace select dev
```

## Iteration patterns used in main.tf

- **List iteration with `count`**
  - Resource: `random_string.list`
  - Uses `count = length(var.regions)` to create one resource instance per list element.
- **Map iteration with `for_each`**
  - Resource: `random_string.map`
  - Uses `for_each = var.regions_instance_count` to create instances keyed by map keys.

### Workspace state locations (local backend)

- Local state files are stored under `terraform.tfstate.d/<workspace>/terraform.tfstate`.
- Example from this lab:
  - `terraform.tfstate.d/dev/terraform.tfstate`
  - `terraform.tfstate.d/prod/terraform.tfstate`

## Setting sensitive variables (api_key)

```powershell
# current session only
$env:TF_VAR_api_key = "your-dev-api-key"

# persist for future sessions (reopen terminal to take effect)
setx TF_VAR_api_key "your-dev-api-key"
```

Or via tfvars files (do not commit secrets):

```hcl
# .\env\dev.tfvars
api_key = "your-dev-api-key"
```

## About sensitive outputs

- **Sensitive flag behavior**: `sensitive = true` hides values in CLI/UI, but the plaintext still exists in the Terraform state. Treat state as sensitive.
- **State safety**: Avoid committing state. Prefer a remote backend with restricted access.
- **Minimize exposure**: Avoid outputting secrets (like `api_key`) unless strictly needed for local testing.
- **If you keep an output**: Mark it `sensitive = true`. Consumers will see it redacted in CLI, but it remains in state.
- **Better patterns**:
 - Pass secrets in via `TF_VAR_*` or a secure secrets manager.
 - Don’t create an output for the secret; reference it directly where needed.
 - If an application needs the secret, provision it into a secure store (e.g., Key Vault/Secrets Manager) and output only a reference (name/URI), not the value.

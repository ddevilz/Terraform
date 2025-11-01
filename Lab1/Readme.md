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

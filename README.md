# IaC Lab Exercises — tuliocruz

A collection of Infrastructure-as-Code (IaC) lab exercises and examples used for learning and teaching. This repository contains Terraform exercises and supporting files to practice provisioning cloud resources, following Thoughtworks lab exercises patterns.

## What you'll find here

- Terraform entrypoint files in the workspace (separeted by module).

## Quick start (Terraform)

Prerequisites:

- macOS or Linux (Windows WSL supported)
- Terraform (v1.0+ recommended). Install from https://learn.hashicorp.com/tutorials/terraform/install-cli
- Git and an account with the cloud provider you intend to use (credentials configured locally)

Basic workflow (run from the directory that contains the Terraform files you want to apply):

```bash
# initialize the working directory
terraform init

# see what will change
terraform plan

# apply the changes (will prompt for confirmation)
terraform apply

# when finished, destroy the resources to avoid charges
terraform destroy
```

If you prefer non-interactive apply (CI or scripts), pass `-auto-approve`.

## Repository layout & conventions

- Use the `main` branch as the default branch. When pushing local changes, push the `main` branch:

```bash
git push --set-upstream origin main
```

## Testing and quality gates

- Lint Terraform with `tflint` or `terraform validate`:

```bash
terraform validate
# optionally: tflint
```

- Keep state out of the repo. Use remote backends (S3/GCS/Azure) for shared work.

## Contact

Maintainer: tuliolucas =)

---

Tell me which if wanna talk more about it or event have the access to the classes involved to this repository.

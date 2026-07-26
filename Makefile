# Enterprise Platform Engineering Makefile for Azure Landing Zone

.PHONY: all fmt lint checkov plan apply docs clean

ENV ?= dev

all: fmt lint checkov

fmt:
	@echo "==> Formatting Terraform & Terragrunt HCL..."
	terraform fmt -recursive
	terragrunt hclfmt

lint:
	@echo "==> Running TFLint..."
	tflint --init
	tflint --recursive

checkov:
	@echo "==> Running Checkov Infrastructure Security Scan..."
	checkov -d . --framework terraform --soft-fail

plan:
	@echo "==> Executing Terragrunt Plan for environment [$(ENV)]..."
	cd terragrunt/$(ENV) && terragrunt plan

apply:
	@echo "==> Executing Terragrunt Apply for environment [$(ENV)]..."
	cd terragrunt/$(ENV) && terragrunt apply -auto-approve

docs:
	@echo "==> Generating Terraform Documentation..."
	terraform-docs markdown table modules/aks > modules/aks/README.md
	terraform-docs markdown table modules/network > modules/network/README.md
	terraform-docs markdown table modules/ai_foundry > modules/ai_foundry/README.md

clean:
	@echo "==> Cleaning Terragrunt caches..."
	find . -type d -name ".terragrunt-cache" -exec rm -rf {} +
	find . -type d -name ".terraform" -exec rm -rf {} +

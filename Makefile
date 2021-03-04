.SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.SECONDEXPANSION:
.DELETE_ON_ERROR:
.DEFAULT_GOAL :=help

## Prints list of tasks
help:
	@awk 'BEGIN {FS=":"} /^## .*/,/^[a-zA-Z0-9_-]+:/ { if ($$0 ~ /^## /) { desc=substr($$0, 4) } else { printf "\033[36m%-30s\033[0m %s\n", $$1, desc } }' Makefile | sort
.PHONY: help

## TF bootstrap
bootstrap:
	terraform init -input=false
.PHONY: bootstrap

## TF plan
plan:
	terraform plan -input=false
.PHONY: plan

## TF apply
apply:
	terraform apply -input=false -auto-approve
.PHONY: apply

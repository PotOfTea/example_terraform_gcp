.DEFAULT_GOAL := deploy

NAME    				 ?= reinis-test
export TF_VAR_name       ?= $(NAME)


terraform ?= terraform-v0.15
gcloud 	  ?= gcloud


export TF_DATA_DIR ?= .terraform/$(NAME)
export TF_LOG_PATH ?= $(TF_DATA_DIR)/terraform.log
export TF_CLI_ARGS ?= -input=false
export TFPLAN      := $(TF_DATA_DIR)/$(NAME).tfplan


deploy: init plan apply

init:
	@mkdir -p $(TF_DATA_DIR)
	$(terraform) init -get=true $(TF_CLI_ARGS) -reconfigure -force-copy
.PHONY: init

plan:
	$(terraform) plan $(TF_CLI_ARGS) -out=$(TFPLAN)
.PHONY: plan

apply:
	$(terraform) apply $(TF_CLI_ARGS) $(TFPLAN)
	@echo
.PHONY: apply


destroy: TF_CLI_ARGS:=-destroy $(TF_CLI_ARGS)
destroy: plan

undeploy: init  destroy apply
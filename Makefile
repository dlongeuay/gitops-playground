.DEFAULT_GOAL := help

PROJECT_NAME = gitops-playground
REGISTRY_PORT = 37893

.PHONY: help
help: ## View help information
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: asdf-bootstrap
asdf-bootstrap: ## Install all tools through asdf-vm
	asdf plugin-add argocd 	|| asdf install argocd
	asdf plugin-add flux2   || asdf install flux2
	asdf plugin-add k3d     || asdf install k3d
	asdf plugin-add kubectl || asdf install kubectl

.PHONY: k8s-bootstrap
k8s-bootstrap: ## Create a Kubernetes cluster for local development
	k3d cluster create $(PROJECT_NAME) -p "8000:80@loadbalancer" || echo "Cluster already exists"

.PHONY: flux-bootstrap
flux-bootstrap: ## Install flux in k3d cluster
	flux install
	flux create source git gitops-playground \
	    --url=https://github.com/dannylongeuay/gitops-playground \
	    --branch=main
	flux create kustomization bootstrap \
		--source=GitRepository/gitops-playground \
		--path="./kustomization/flux/bootstrap/base" \
		--prune=true \
		--interval=5m
		
.PHONY: argo-bootstrap
argo-bootstrap: ## Install argo in k3d cluster
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml

.PHONY: bootstrap
bootstrap: asdf-bootstrap k8s-bootstrap flux-bootstrap argo-bootstrap ## Perform all bootstrapping required for local development

.PHONY: create
create: bootstrap ## Create local development environment
	@echo "Created k3d cluster and bootstrapped GitOps tools"

.PHONY: clean
clean: ## Destroy local development environment
	k3d cluster delete $(PROJECT_NAME) || echo "No cluster found"


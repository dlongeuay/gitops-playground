# GitOps Playground

This repo serves as a starting point to explore and learn GitOps tooling in a local Kubernetes cluster.

## What is GitOps?

GitOps is the automation of DevOps best practices for application management.

Key Properties:
- Git is the single source of truth
- System state is defined in a declarative manner
- CI/CD is responsible for building, testing, and deployment
- Commits are the trigger for changes to a target environment
- Changes to the environment can be monitored and provide feedback

## Application Deployment

- [Flux](https://github.com/fluxcd/flux2)
  - Pros
    - Supports [Helm](https://helm.sh/) and [Kustomize](https://kustomize.io/)
    - Simple approach to automatic application deployments
    - Multi-tenant support
  - Cons
    - CLI driven, no native UI support
- [ArgoCD](https://argo-cd.readthedocs.io/)
  - Pros
    - Supports Helm and Kustomize
    - Native UI
    - Multi-tenant support
  - Cons
    - Argo deployments are a bit more involved
    
## Local Development

Local development leverages [K3D](https://k3d.io/) to create a local Kubernetes cluster. [Kubectl](https://kubernetes.io/docs/tasks/tools/) and [FluxCLI](https://fluxcd.io/docs/installation/#install-the-flux-cli) are used to bootstrap the cluster. 

A hello world app will be deployed via Flux and ArgoCD. The built-in [Traefik](https://doc.traefik.io/traefik/) ingress controller is used to proxy the applications.

URL endpoints:
- http://helloflux.localhost:8000/
- http://helloargo.localhost:8000/

### Requirements

- [ASDF-VM](https://asdf-vm.com/)
- [Docker](https://www.docker.com/)

### Usage

Run `make create` to create the local Kubernetes cluster and bootstrap Flux and ArgoCD.

### Make Targets

```
❯ make
help                           View help information
asdf-bootstrap                 Install all tools through asdf-vm
flux-bootstrap                 Install flux in k3d cluster
argo-bootstrap                 Install argo in k3d cluster
bootstrap                      Perform all bootstrapping required for local development
create                         Create local development environment
clean                          Destroy local development environment
```

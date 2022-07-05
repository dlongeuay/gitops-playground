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
    - Supports Helm and Kustomize
    - Simple approach to automatic application deployments
    - Multi-tenant support
  - Cons
    - CLI driven, no native UI support

### Alternatives:

- [ArgoCD](https://argo-cd.readthedocs.io/)
  - *Disclaimer: No personal experience with ArgoCD.
  - Pros
    - Supports Helm and Kustomize
    - Native UI
    - Multi-tenant support
  - Cons
    - Argo deployments are a bit more involved
    
## Local Development

TODO

### Requirements

- [ASDF-VM](https://asdf-vm.com/)
- [Docker](https://www.docker.com/)


# Homelab infrastructure

Declarative Kubernetes configuration for a single-node k3s homelab on Debian.
Resources are added incrementally while learning how they work.

The Casita application source code and container image builds belong in
[the application repository](https://github.com/BoaglioFranco/groceries).
This repository describes how applications run in the homelab, including other
self-hosted services as they are introduced.

## Current scope

`apps/casita/namespace.yaml` declares the `casita` namespace. It creates a
scope for the application's Kubernetes resources; it starts no workloads and
does not configure network isolation or resource quotas.

K3s is already installed on the server. This repository does not yet automate
host preparation or the k3s installation.

## Apply the namespace

Clone this repository onto the server. From its root directory, use the existing
k3s installation and its configured Kubernetes credentials:

```bash
k3s kubectl apply -f apps/casita/namespace.yaml
k3s kubectl get namespace casita
k3s kubectl get pods -n casita
```

Expect the namespace to be `Active` and the pod list to be empty initially.
Applying an unchanged manifest again is safe. Commit and push manifest changes
to record them in Git; apply the selected revision on the server to change the
cluster. Pushing to GitHub alone does not deploy anything.

Avoid deleting a namespace as a cleanup shortcut: deletion also deletes the
namespaced resources it contains.

## Credentials

Keep kubeconfigs, tokens, private keys, and unencrypted Kubernetes Secret
manifests out of Git. Base64-encoded Secret values are not encrypted. The ignore
rules cover common credential filenames but cannot detect secrets in arbitrary
files; review changes before committing.

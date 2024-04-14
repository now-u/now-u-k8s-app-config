#!/bin/bash

# Setup cluster
sudo snap install microk8s --classic --channel=1.29
sudo usermod -a -G microk8s $USER
sudo mkdir -p ~/.kube
sudo chown -f -R $USER ~/.kube
microk8s status --wait-ready

microk8s config > ~/.kube/config

microk8s enable dns
microk8s enable hostpath-storage
microk8s enable registry
microk8s enable observability
microk8s enable metrics-server
microk8s enable ingress dashboard
microk8s enable cert-manager
microk8s enable metallb:172.187.88.151-172.187.88.151
microk8s enable community
microk8s enable cloudnative-pg

# Install argocd
microk8s kubectl create namespace argocd
microk8s kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Install argo app
microk8s kubectl apply -f application.yaml

# Install sealed secrets
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets

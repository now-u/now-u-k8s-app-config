# now-u-k8s-app-config

k8s setup

```
microk8s enable dns hostpath-storage registry prometheus metrics-server ingress dashboard cert-manager metallb community cloudnative-pg storage
```

Note the ip range for metallb should be the ip of the server

Install argo: https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/
And apply `application.yaml`

Install sealed secrets

Note: `storage` addon should only be used on single node clusters
```
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets
```

## Create a secret

https://github.com/bitnami-labs/sealed-secrets?tab=readme-ov-file#usage

Create a secret yaml file as usual. Then run `kubeseal -f thatfile.json -w output.json`

## Access argo

Username: admin
Passowrd:
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Access grafana

Username: admin
Password:
```
kubectl get secrets -n observability kube-prom-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d
```

## Get kubeconfig

```
(host) microk8s config > .kube/config
(local) scp <host>:.kube/config ~/.kube/config
```
Then update kubeconfig with external ip and:
https://stackoverflow.com/a/63470856/13473952
scp

## TODO

- Create meiliseach master key as k8s secret and set in template and api deployment env
- Generate meilisearch API key which is the same value as the existing key https://github.com/orgs/meilisearch/discussions/421#discussioncomment-2636763

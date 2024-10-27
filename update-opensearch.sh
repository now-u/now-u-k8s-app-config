POD=$(kubectl -n now-u-prod get pod -l app=now-u-causes -o jsonpath="{.items[0].metadata.name}")
kubectl -n now-u-prod exec $POD -- ./manage.py populateMeilisearchIndex

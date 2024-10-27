proxy-db:
	kubectl -n now-u-prod get secrets now-u-causes-db-app -o jsonpath="{.data.dbname}" | base64 -d | xargs printf 'db: %s\n'
	kubectl -n now-u-prod get secrets now-u-causes-db-app -o jsonpath="{.data.user}" | base64 -d | xargs printf 'user: %s\n'
	kubectl -n now-u-prod get secrets now-u-causes-db-app -o jsonpath="{.data.password}" | base64 -d | xargs printf 'password: %s\n'
	kubectl -n now-u-prod port-forward services/now-u-causes-db-rw 5433:5432

sync-search:
	./update-opensearch.sh

get-argcd-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

ssh-causes:
	kubectl -n now-u-prod exec --stdin --tty $(kubectl -n now-u-prod get pods --selector=app=now-u-causes -o jsonpath='{.items[0].metadata.name}') -- /bin/bash

This repo contains argo helm charts to set up an 'app of apps' as described
here: https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/

Once argo is installed in the cluster, you can slam this into the environment
with:

```
$ argocd app create apps \
		--dest-namespace MY_NAMESPACE_HERE \
		--dest-server https://kubernetes.default.svc \
		--repo https://REPO_URL_HERE \
		--path apps

$ argocd app sync apps
```


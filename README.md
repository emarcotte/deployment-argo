This repo contains argo helm charts to set up an 'app of apps' as described
here: https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/

Once argo is installed in the cluster, you can slam this into the environment
with:

```
argocd app create train --dest-namespace argocd --dest-server https://server_here --repo https://github.com/emarcotte/deployment-argo --path ./

$ argocd app sync train --dry-run
```

The idea of this model is that the entire release train for all clients is in
one model. This could be split apart. Since the state in argo tracks versions
and things like that, we would not have impact to other components for other
clients when changing a particular component in a particular client.


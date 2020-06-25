This repo contains argo helm charts to set up an 'app of apps' as described
here: https://argoproj.github.io/argo-cd/operator-manual/cluster-bootstrapping/

Once argo is installed in the cluster, you can slam this into the environment
with:

```
$ argocd app create train --dest-namespace argocd --dest-server https://kubernetes.default.svc --repo https://github.com/emarcotte/deployment-argo --path ./

$ argocd app sync train --dry-run
```

The idea of this model is that the entire release train for all clients is in
one model. This could be split apart. Since the state in argo tracks versions
and things like that, we would not have impact to other components for other
clients when changing a particular component in a particular client.

Template debugging is done via helm (as far as I can tell):

```
helm2 template . --name train --namespace argocd --kube-version 1.14 --debug
```

And _supposedly_ also via:

```
$ argocd app sync train --local ./
```

Bootstrap setup is in `setup.sh` and installs to current `kubectl` context.

The templates here detect client environment pairs by globbing all the files
under `client` and parsing their names. To add or remove an environment simply
create a new `client/env.yaml` file. This could be an effective way to pull
things in and out of scope for a potential migration from current tools.

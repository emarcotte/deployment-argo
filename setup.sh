set -ex

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Wait for external access (race condition here)
sleep 60;

echo "Here's the argo IP:"
argo_ip=$(kubectl get service -n argocd argocd-server -o json | jq '.status.loadBalancer.ingress[0].ip' -r)

echo "Here's the initial setup password:"
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

echo "Logging in (use the password above)"
argocd login $argo_ip

echo "Ok, change the password now (use the password above)"
argocd account update-password

echo "Setting up the release train on the argo host cluster"
argocd app create train --dest-namespace argocd --dest-server https://kubernetes.default.svc --repo https://github.com/emarcotte/deployment-argo --path ./

argocd app sync train --dry-run

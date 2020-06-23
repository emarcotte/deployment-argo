set -ex
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
sleep 60;
echo; echo;
echo "***"
echo "Here's the argo URL:"
argo_ip=$(kubectl get service -n argocd argocd-server -o json | jq '.status.loadBalancer.ingress[0].ip' -r)
argo_url="http://$argo_ip:443"
echo;
echo;
echo "Here's the initial setup password:"
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

echo "Logging in"

argocd login $argo_ip

echo Ok, change the password now
argocd account update-password

argocd cluster add $(kubectl config current-context)


export AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')
export AWS_DEFAULT_REGION=$AWS_REGION

cat cluster-config-template.yaml | envsubst > cluster-config.yaml
eksctl create cluster -f cluster-config.yaml

aws eks update-kubeconfig --name 'GitOps-Workshop'
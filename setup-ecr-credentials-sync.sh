#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Cluster name is required."
    exit 1
fi

CLUSTER_NAME="$1"

export ECR_SECRET_NAME=ecr-credentials

eksctl create iamserviceaccount \
  --cluster=$CLUSTER_NAME \
  --name=ecr-credentials-sync \
  --namespace=flux-system \
  --attach-policy-arn=arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly \
  --approve

cat ecr-credentials-sync-template.yaml \
  | envsubst > ecr-credentials-sync.yaml

kubectl apply -f ecr-credentials-sync.yaml

kubectl create job \
  --from=cronjob/ecr-credentials-sync \
  -n flux-system \
  ecr-credentials-sync-init

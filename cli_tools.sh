#!/bin/bash

cd ~
sudo yum groupinstall 'Development Tools' -y
sudo yum install -y jq gettext bash-completion moreutils
sudo pip install --upgrade pip

# AWS CLI v2
AWS_CLI_VERSION=$(aws --version | cut -d/ -f2 | cut -d. -f1)
AWS_CLI_INSTALL_OPTS=""
if [[ "$AWS_CLI_VERSION" -eq 2 ]]; then
  AWS_CLI_INSTALL_OPTS="--update"
fi
curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install $AWS_CLI_INSTALL_OPTS
rm -rf awscliv2.zip aws

# Install kubectl
curl -LO --silent https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --short --client

# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv -v /tmp/eksctl /usr/local/bin
eksctl version

# Install Helm 3
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh
helm version

# Install Flux v2 CLI
wget https://github.com/fluxcd/flux2/releases/download/v0.9.0/flux_0.9.0_linux_amd64.tar.gz
tar -zxvf flux_0.9.0_linux_amd64.tar.gz
sudo mv ./flux /usr/local/bin/flux
rm -rf flux_0.9.0_linux_amd64.tar.gz
flux --version

source ./env.txt

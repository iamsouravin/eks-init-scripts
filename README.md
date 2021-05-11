# Repo for EKS and GitOps Workshops

## Resources

### `cli_tools.sh`

Installs the pre-requisite CLI tools.

#### Installed tools list

* `Development Tools` group
* `jq`
* `gettext`
* `bash-completion`
* `moreutils`
* `awscli v2`
* `kubectl`
* `eksctl`
* `helm v3`
* `flux v2`

### `create_cluster.sh`

Creates EKS cluster for the workshop.
Substitutes the environment variables in `cluster-config-template.yaml` and genertes a `cluster-config.yaml` to use as input to `eksctl`.

### `cluster-config-template.yaml`

Template file with envrionment variables used to generate `cluster-config.yaml`.

#### Environment Variables

`AWS_REGION` - AWS region where the cluster will be created.

### Cluster Attributes

| Attribute | Value |
|-----------|-------|
| **Name** | `GitOps-Workshop` |
| **Region** | `${AWS_REGION}` |
| **Version** | `1.19` |
| **Cluster Logging Enabled** | Yes |
| **Cluster Logging Types** | All |
| **Node Group Type** | Managed |
| **Node Group Name** | `managed-ng-1` |
| **Instance Type** | `t3.large` |
| **Desired Capacity** | `1` |
| **Min Size** | `1` |
| **Max Size** | `2` |
| **Private Networking** | `true   |
| **Volume Size** | 100 GiB |
| **Volume Type** | `gp2` |
| **Volume Encrypted** | `true` |
| **OIDC Enabled** | `true` |

# Get Started With AWS EKS Infra with Terraform

## Index
- [Assumptions](#assumptions)
- [Prerequisite - Terraform Backend to store remote states ](#prerequisites)
- [Deploy K8 Cluster in AWS EKS with Terraform](#deploy_cluster)
- [Add AWS IAM users or roles to be able to talk to a K8s cluster](#add_iam_user_role)
- [Cleanup](#cleanup)

## Assumptions <a name="assumptions"></a>
- We are using AWS profile `cr-labs-master` as an IAM account's identity
- We are using AWS profile `cr-labs-hisashi` to assume an IAM role. My `~/.aws/config` is below:
```
[profile cr-labs-hisashi]
source_profile = cr-labs-master
role_arn = arn:aws:iam::734811867068:role/Admin
region = eu-central-1
output = text
```

## Prerequisite - Terraform Backend to store remote states <a name="prerequisites"></a>
You can specify Terraform provider to either:
- assume a role
- use AWS profile name

Choose whichever that suits your need.

### If Terraform Provider is assuming a role (simulating an AWS identity in IAM account assuming a role into a shared/dev/prod account)
[composition/terraform_backend/backend.config](composition/terraform_backend/backend.config) should have "role_arn" specified:
```
bucket         = "s3-ec1-eks-terraform-demo-dev-backend-terraform-states"
region         = "eu-central-1"
key            = "eu-central-1/terraform_backend/terraform.tfstate"
encrypt        = true
role_arn = "arn:aws:iam::xxxxxxxxxx:role/Admin"
```
[composition/terraform_backend/providers.tf](composition/terraform_backend/providers.tf) should have "assume_role":
```
provider "aws" {
  version = "~> 2.7.0"
  region  = "${var.region}"
  # this is for TF to use AWS PROFILE
  # profile = var.profile_name

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  }
}
```
After that, create a S3 bucket, set AWS_PROFILE, and execute terraform:
```
#########################
# Configure your AWS CLI and PROFILE
#########################
$ vim ~/.aws/config

[profile cr-labs-hisashi]
source_profile = cr-labs-master
role_arn = arn:aws:iam::xxxxxxxxxx:role/Admin
region = eu-central-1
output = text

$ export AWS_PROFILE=cr-labs-hisashi
$ aws s3 mb s3://s3-ec1-eks-terraform-demo-dev-backend-terraform-states
$ aws s3 ls
$ cd composition/terraform_backend
$ export AWS_PROFILE=cr-labs-master

# Edit terraform.tfvars
account_id = "YOUR_AWS_ACCOUNT_ID"

$ terraform init -backend-config=backend.config
$ terraform plan
$ terraform apply --auto-approve
```

### If Terraform Provider is using access key and secret access key and AWS_PROFILE
[composition/terraform_backend/backend.config](composition/terraform_backend/backend.config) should **NOT** have "role_arn" specified:
```
bucket         = "s3-ec1-eks-terraform-demo-dev-backend-terraform-states"
region         = "eu-central-1"
key            = "eu-central-1/terraform_backend/terraform.tfstate"
encrypt        = true
```
[composition/terraform_backend/providers.tf](composition/terraform_backend/providers.tf) should **NOT** have "assume_role", instead "profile" should be be specified:
```
provider "aws" {
  version = "~> 2.7.0"
  region  = "${var.region}"
  profile = var.profile_name

  # this is for TF to assume a role
  # assume_role {
  #  role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  #}
}
```
After that, create a S3 bucket, set AWS_PROFILE, and execute terraform:
```
$ export AWS_PROFILE=cr-labs-hisashi
$ aws s3 mb s3://s3-ec1-eks-terraform-demo-dev-backend-terraform-states
$ aws s3 ls
$ cd composition/terraform_backend

# Edit terraform.tfvars
account_id = "YOUR_AWS_ACCOUNT_ID"

$ terraform init -backend-config=backend.config
$ terraform plan
$ terraform apply --auto-approve
```

## Deploy K8 Cluster in AWS EKS with Terraform  <a name="deploy_cluster"></a>
### If Terraform Provider is assuming a role (simulating an AWS identity in IAM account assuming a role into a shared/dev/prod account)
[composition/eks-cluster/eu-central-1/dev/backend.config](composition/eks-cluster/eu-central-1/dev/backend.config) should have "role_arn" specified:
```
bucket         = "s3-ec1-eks-terraform-demo-dev-backend-terraform-states"
region         = "eu-central-1"
key            = "eu-central-1/terraform_backend/terraform.tfstate"
encrypt        = true
role_arn = "arn:aws:iam::xxxxxxxxxx:role/Admin"
```
[composition/eks-cluster/eu-central-1/dev/providers.tf](composition/eks-cluster/eu-central-1/dev/providers.tf) should have "assume_role":
```
provider "aws" {
  version = "~> 2.7.0"
  region  = "${var.region}"
  # this is for TF to use AWS PROFILE
  # profile = var.profile_name

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  }
}
```
Then execute Terraform
```
$ export AWS_PROFILE=cr-labs-master
$ cd composition/eks-cluster/eu-central-1/dev
$ terraform init -backend-config=backend.config
$ terraform apply --auto-approve

# Write the kubeconfig file to `~/.kube/config` to allow kubectl client to connect to K8s cluster. 
$ mkdir ~/.kube
$ terraform output eks_kubeconfig > ~/.kube/config

$ export AWS_PROFILE=cr-labs-hisashi

# get cluster info to validate kubectl works
$ kubectl cluster-info
$ kubectl get pods

# Join worker nodes to the cluster (this is important! Without this, pods can't be created at later steps)
$ kubectl apply -f config-map-aws-auth_eks-cluster-terraform-demo.yaml
```

### If Terraform Provider is using access key and secret access key and AWS_PROFILE
[composition/eks-cluster/eu-central-1/dev/backend.config](composition/eks-cluster/eu-central-1/dev/backend.config) should **NOT** have "role_arn" specified:
```
bucket         = "s3-ec1-eks-terraform-demo-dev-backend-terraform-states"
region         = "eu-central-1"
key            = "eu-central-1/terraform_backend/terraform.tfstate"
encrypt        = true
```
[composition/eks-cluster/eu-central-1/dev/providers.tf](composition/eks-cluster/eu-central-1/dev/providers.tf) should **NOT** have "assume_role", instead "profile" should be be specified:
```
provider "aws" {
  version = "~> 2.7.0"
  region  = "${var.region}"
  profile = var.profile_name

  # this is for TF to assume a role
  # assume_role {
  #  role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
  #}
}
```
Then execute Terraform
```
$ export AWS_PROFILE=cr-labs-hisashi
$ cd composition/eks-cluster/eu-central-1/dev
$ terraform init -backend-config=backend.config
$ terraform apply --auto-approve

# Write the kubeconfig file to `~/.kube/config` to allow kubectl client to connect to K8s cluster. 
$ mkdir ~/.kube
$ terraform output eks_kubeconfig > ~/.kube/config

# get cluster info to validate kubectl works
$ kubectl cluster-info
$ kubectl get pods

# Join worker nodes to the cluster (this is important! Without this, pods can't be created at later steps)
$ kubectl apply -f config-map-aws-auth_eks-cluster-terraform-demo.yaml
```

## Add AWS IAM users or roles to be able to talk to a K8s cluster <a name="add_iam_user_role"></a>
Refs:
- [Managing Users or IAM Roles for your Cluster](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html)
- [Create a kubeconfig for Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
- [error: You must be logged in to the server (Unauthorized) -- same IAM user created cluster](https://github.com/kubernetes-sigs/aws-iam-authenticator/issues/174)
- [How auth works in EKS with IAM Users](http://marcinkaszynski.com/2018/07/12/eks-auth.html)

Let's say AWS_PROFILE `cr-labs-hisashi` created a K8s cluster. This identity can access the cluster by default because it's the creator of the cluster.

Now let's add another IAM user `tester` by going to AWS Console, adding a new IAM user, and giving it an Admin role.

After that, configure your AWS CLI by adding a new AWS profile.
```
$ vim ~/.aws/credentials

# add these lines below
[cr-labs-tester]
aws_access_key_id = NEW_ACCESS_KEY
aws_secret_access_key = NEW_SECRET_ACCESS_KEY
```

Try to access the cluster using the new IAM identity
```
$ export AWS_PROFILE=cr-labs-tester

# confirm the access to AWS
$ aws s3 ls
s3-ec1-eks-terraform-dev-backend-terraform-states

# confirm you can't acccess the K8s cluster
$ kubectl get all
error: You must be logged in to the server (Unauthorized)
```

This is because the new user isn't added to a K8s ConfigMap in the backend to allow access to the cluster. Let's see the ConfigMap that contains info about what IAM users and roles have access to the cluster.
```
# switch back to the original AWS profile
$ export AWS_PROFILE=cr-labs-hisashi

# get ConfigMap in namespace "kube-system"
$ kubectl describe cm aws-auth -n kube-system
Name:         aws-auth
Namespace:    kube-system
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","data":{"mapAccounts":"","mapRoles":"- rolearn: arn:aws:iam::YOUR_AWS_ACCOUNT_#:role/eks-terraform-blackjack-demo201908281554...

Data
====
mapAccounts:
----

mapRoles:
----
- rolearn: arn:aws:iam::YOUR_AWS_ACCOUNT_#:role/eks-terraform-blackjack-demo20190828155420106300000005
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes

mapUsers:
----

Events:  <none>
```
You see, `mapUsers:` is empty. To add a new user to this `mapUsers`, modify [composition/eks-cluster/eu-central-1/dev/terraform.tfvars](composition/eks-cluster/eu-central-1/dev/terraform.tfvars) to pass a new user
```
# add other IAM users who can access a K8s cluster (by default, the IAM user who created a cluster is given access already)
map_users    = [
   {
     user_arn = "arn:aws:iam::YOUR_AWS_ACCOUNT_#:user/tester"
     username = "tester"
     group    = "system:masters"
   },
]
```
Then apply changes
```
terraform plan
terraform apply --auto-approve
```

After that, recheck the configmap
```
$ kubectl describe cm aws-auth -n kube-system
Name:         aws-auth
Namespace:    kube-system
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","data":{"mapAccounts":"","mapRoles":"- rolearn: arn:aws:iam::xxxxxxxxxx:role/eks-terraform-blackjack-demo201908281554...

Data
====
mapRoles:
----
- rolearn: arn:aws:iam::xxxxxxxxxx:role/eks-terraform-blackjack-demo20190828155420106300000005
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes

mapUsers:
----
- userarn: arn:aws:iam::xxxxxxxxxx:user/tester
  username: tester
  groups:
    - system:masters

mapAccounts:
----

Events:  <none>
```
Now new user is added in these lines:
```
mapUsers:
----
- userarn: arn:aws:iam::xxxxxxxxxxx:user/tester
  username: tester
  groups:
    - system:masters
```

Let's verify the user `tester` has access to the cluster
```
$ export AWS_PROFILE=cr-labs-tester

$ kubectl get all
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   172.20.0.1   <none>        443/TCP   66m
```
Tada!


## Cleanup <a name="cleanup"></a>
```
terraform destroy
```

## Playing with AWS - K8s authentication using iam-authenticator
1. get token
```
aws-iam-authenticator token -i eks-cluster-terraform | python -m json.tool | jq -r ".status.token"
```
2. validate token 
```
aws-iam-authenticator  verify -t $(aws-iam-authenticator token -i eks-cluster-terraform |  python -m json.tool | jq -r ".status.token") -i eks-cluster-terraform
```

## Install Tools

Install kubectl and Helm CLI (Command Line Interface) tools

---

## Install kubectl

kubectl is the CLI tool used to interact with a Kubernetes cluster

You can install it from Google Storage:
`curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl`{{copy}}

Check that kubectl installed correctly
`kubectl version`{{copy}}

---

## Install Helm 3

helm is the CLI tool used to manage deployments of packages to a Kubernetes cluster

Download and Unzip the Helm package from the official Github repo
`curl -L https://get.helm.sh/helm-v3.2.2-linux-amd64.tar.gz | tar xvz && mv linux-amd64/helm /usr/local/bin/helm`{{execute}}

Check that Helm installed correctly
`helm version`{{execute}}

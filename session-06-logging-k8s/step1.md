## Start minikube cluster and setup Helm v3

1. Run following commands to start your Minikube session:

    `minikube start`{{execute}}

    Note: This may take up to 5 mins

2. Check to make sure minikube is up and running
    
    `minikube status`{{execute}}

Install Helm 3

1. Curl Helm3 install script

    `curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3`{{execute}}

2. Change file permissions to allow execution of helm.sh

    `chmod 700 get_helm.sh`{{execute}}


3. Execute the helm sript

     `./get_helm.sh`{{execute}}

4. Check to verify you have Helm3 installed

    `helm version`{{execute}}

## FAQ:

Q1: What is Helm?
A: Helm is like a package manager (apt, yum, apk, etc.) that installs and manages applications utilizing yaml files.

Q2: Why Minikube?
A: Minikube is a simple way to start up a kubernetes cluster without having to utilize `kubeadm` and setup all the backend config.



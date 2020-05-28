## Start minikube cluster and setup Helm v3
1. Run following commands to start your Minikube session:

    `minikube start`{{execute}}

    Note: This may take up to 5 mins

    You should see the following when minikube is complete

    ```bash
    * Done! kubectl is now configured to use "minikube"
    ```

2. Check to make sure minikube is up and running
    
    `minikube status`{{execute}}

    You should see the following output

    ```bash
    host: Running
    kubelet: Running
    apiserver: Running
    kubeconfig: Configured
    ```

## Install Helm 3

3. Curl the helm3 install script

    `curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3`{{execute}}

4. Change file permissions to allow execution of helm.sh

    `chmod 700 get_helm.sh`{{execute}}


5. Execute the helm sript

    `./get_helm.sh`{{execute}}

6. Check to verify you have Helm3 installed

    `helm version`{{execute}}

## FAQ:

- Q1: What is Helm?
    - A: Helm is like a package manager (apt, yum, apk, etc.) that installs and manages applications utilizing yaml files.

- Q2: Why Minikube?
    - A: Minikube is a simple way to start up a kubernetes cluster without having to utilize `kubeadm` and setup all the backend config.


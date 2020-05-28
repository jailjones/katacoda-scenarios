## Lets setup your kubernetes environment for your Helm chart

1. Create the log-system namespace

    `kubectl create namespace log-system`{{execute}}

2. Add the elastic helm repo

    `helm repo add elastic https://helm.elastic.co`{{execute}}

3. Update your helm repo

    `helm repo update`{{execute}}

4. Download the minikube yaml file for your ELK stack to utilize

    `curl -O https://raw.githubusercontent.com/elastic/Helm-charts/master/elasticsearch/examples/minikube/values.yaml`{{execute}}


## FAQ:

- Q1: Why are we adding an `elastic` repo and not the stable repo as before?
    - A: Elastic has their own charts repo that they manage and share with the public. It is recommended to utilize their helm chart versus other 3rd parties.

- Q2: Whats the purpose of the values.yaml file?
    - A: This file contains parameters that are meant to support a minikube cluster install of your ELK stack. If you were to run the default helm chart, it is expecting a mult-node cluster where our minikube cluster is a single node.
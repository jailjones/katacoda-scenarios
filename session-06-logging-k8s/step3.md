## Install Elastic

1. Install `elasticsearch` helm chart from the elastic repo you added in step 2

    `helm install elasticsearch elastic/elasticsearch -f ./values.yaml --set service.type=LoadBalancer --set replicas=2 --namespace log-system`{{execute}}

    >**Note**: This may take up to 5 minutes.

2. Run following commands to verify helm chart successfully installed

    `helm ls -n log-system`{{execute}}

3. Verify if the pods are in `running` state before moving forward

    `kubectl get pods -n log-system`{{execute}}

## FAQ:

- Q1: What does elasticsearch do?
    - A: Elasticsearch is a distributed, RESTful search and analytics engine and is the heart or foundation of the free and open Elastic Stack.       
    - Elasticsearch centrally stores your data for lightning fast search, fine-tuned relevancy, and powerful analytics that      scale with ease.

    - Essentially store, search, and analyze all data types in your environment in a single location.

- Q2: Is it free or does it require and enterprise license?
    - A: Elastic's tools come in multiple varieties as OSS, Enterprise, and cloud solutions. We are utilizing the open-source version of elasticsearch for demo purposes, but to utilize in a 200+ node environment it is highly recommended to review the enterprise or cloud license.

- Q3: Why is replicas set to `1`, why not `3` elasticsearch master nodes as by default?
    - A: Limitations in katacoda minikube only allows us 2 cpus and 4 GB of memory. We need to scale down elasticsearch so there is enough CPU for Kibana and Filebeat.
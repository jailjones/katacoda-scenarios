## Log into Grafana

1. Now lets upgrade the service type for Grafana to `LoadBalancer`

    `helm upgrade prom-op stable/prometheus-operator --set prometheus.service.type=LoadBalancer -n monitor-system`{{execute}}

2. Now run the following and copy the random remote port assigned to Prometheus

    `kubectl get service -n monitor-system`{{execute}}

    - Make sure to copy the 30000+ node port value in the `prom-op-prometheus-operato-prometheus 9090:30XXX`

    - Now select the `plus (+)` on the top of the terminal and choose `select host 1 on port` and insert your `30XXX` number

    - Connect  

3. Log in with the following credentials (default values)

    - user: admin
    - paswword: prom-operator

4. Review some of the pre-built dashboards under the `Home` drop-down

    Dashboards to Review
    - Kubernetes/Pods
    - Kubernetes/Networking/Pods
    - Kubernetes/Compute Resources/Pods

5. Complete the tasks below

    - What is the current `CPU Utilization` of your node?
    - What is the `Memory Utilization` of your cluster?
    - How many pods are currently running in `kube-system`?
    - How many pods are currently running in `monitor`
    - What is the `Average Rate of Bytes` transmitted for namespace=monitor?

6. Find custom dashboards to import

    You can download community built dashboards from `grafana.com/dashboards`

    - Go to grafana.com/dashboards
    - In left pane, change data source to prometheus
    - In search bar, type `kubernetes`
    - Select `Cluster Monitoring for Kubernetes` and copy the ID
        - ID: 10000

    Note: You can copy the ID or the JSON file to import in your grafana environment

7. Import the custom dashboard

    - In the left pane of grafana hit the plus sign (+)
    - Select Import
    - Copy ID from step 5 into
        - Name: keep the default name
        - Folder: General
        - UID: randomly generate
        - DataSource: Prometheus
    - Hit import
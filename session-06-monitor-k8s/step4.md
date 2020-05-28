## Log into Prometheus with LoadBalancer

1.  List the services prometheus-operator helm chart created

    `kubectl get services -n monitor-system`{{execute}}

    You should now see a list of all the services
    - Alert Manager
    - Prometheus
    - Grafana
    - and more

2. Update the helm chart to change Prometheus service type to `LoadBalancer`

    `helm upgrade prom-op stable/prometheus-operator --set prometheus.service.type=LoadBalancer -n monitor-system`{{execute}}

    Why is this needed? To access prometheus we need to expose the port externally. You can choose either a node port or load balancer. Since we are using minikube, loadbalancer makes it simpler since minikube has pre-built configs to access applications easily.

3. Now run the following and copy the random remote port assigned to Prometheus

    `kubectl get service -n monitor-system`{{execute}}

    - Make sure to copy the 30000+ node port value in the `prom-op-prometheus-operato-prometheus 9090:30XXX`

    - Now select the `plus (+)` on the top of the terminal and choose `select host 1 on port` and insert your `30XXX` number

    - Connect

4. Lets check out the UI

    - Check out the "drop-down" next to `Execute` and copy these PromQL commands into the search bar 
        - instance:node_cpu_utilisation:rate1m
        - cluster:node_cpu:sum_rate5m
        - node_memory_MemFree_bytes
        - :node_memory_MemAvailable_bytes:sum
        - container_network_transmit_bytes_total

    Notice how there are so many types of metrics prometheus provides to gain insight into your cluster

5. Go to the "Status" drop-down, lets take a look at some of these options

    - Runtime and Build Information
        - Get all of your details about your prometheus installation
    - Configuration
        - Provides the YAML values of how prometheus was configured by default
        - This is what Helm charts reads and inserts into your prometheus-operator install
        - Pro-Tip: copy this file into version control with a date, if you have any issues you can do a diff to compare what changed
    - Targets
        - Shows you all the containers running in your current environment
    - Service Discovery
        - Basic overview of your applications or services running in your current environment

## FAQ

    - Q1: Why did we need to change service type to `LoadBalancer` in the helm chart?
        - A: By default, the service type is `ClusterIP` which unfortunately cannot be accessed when your minikube is running on a remote environment. 
        
        Therefore, we need to change to a load balancer to make the service externally accessible over the internet.
        
        If you were to run with ClusterIP, you would need to have minikube running on your `local` machine to access from your local safari, chrome, or edge browser. Since clusterIP is private, only your local machine can access a private IP since you share the same network. Private IPs cannot be accessed over the internet unless you use a VPN service.
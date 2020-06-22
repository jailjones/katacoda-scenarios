Once the Pod is Running, take a closer look using the `kubectl describe pod` subcommand:

`kubectl describe pod two-containers`{{execute}}

This subcommand, like `kubectl get pods`, is a generic command you can use to examine any kind of resource, not just Pods. You can also use commands such as `kubectl get deployments`, `kubectl describe service`, and similar commands for any kubernetes API object.

The output is extensive, but you can see our two entries under the `Containers:` key:

```yaml
Name:               two-containers
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node01/172.17.0.38
Start Time:         Wed, 03 Jun 2020 17:07:16 +0000
Labels:             <none>
Annotations:        ...
Status:             Running
IP:                 10.40.0.1
Containers:
  webserver:
    Image:          nginx
    State:          Running
      Started:      Wed, 03 Jun 2020 17:07:22 +0000
    ...

  shell:
    Image:         centos
    Command:
      sh
      -c
      echo "hello kube" && sleep 3600
    State:          Running
      Started:      Wed, 03 Jun 2020 17:07:29 +0000
    ...

Conditions:

Volumes:

QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     ...
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  27s   default-scheduler  Successfully assigned default/two-containers to node01
  Normal  Pulling    26s   kubelet, node01    Pulling image "nginx"
  Normal  Pulled     19s   kubelet, node01    Successfully pulled image "nginx"
  Normal  Created    19s   kubelet, node01    Created container webserver
  Normal  Started    19s   kubelet, node01    Started container webserver
  Normal  Pulling    19s   kubelet, node01    Pulling image "centos"
  Normal  Pulled     12s   kubelet, node01    Successfully pulled image "centos"
  Normal  Created    12s   kubelet, node01    Created container shell
  Normal  Started    12s   kubelet, node01    Started container shell
```

## Pod creation process

In the Events section you can see the sequence of things that Kubernetes did to get the Pod up and running:

1. The cluster chooses a Node, a specific piece of hardware, that can support the Pod. All of the Pod's Containers will run on the same Node, and will remain there for the entire life of the Pod. This simplifies the Pod's design, since it doesn't have to concern itself with moving around between Nodes. In the event that a Node is lost, a replacement Pod will be spun up on a different Node.
1. The cluster pulls down docker images requested by the spec. Our lab images come from the public docker hub, but cluster admins can configure specific hubs to ensure the cluster only runs authorized code.
1. The cluster creates the Container sub-objects and starts each one. Once all the Containers are up and running, the Pod itself is marked Running.

## init containers

If you want more control over the startup process, you can use _Init Containers_, which run before the primary, "App Containers". Init Containers can do things such as gathering configuration over a network, then storing it on a shared disk for the other Containers to use.
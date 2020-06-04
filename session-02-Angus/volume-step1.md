# 1. Deploy a Pod with two Containers

Examine the pod-two-containers-no-volumes.yaml file. It contains the definition of a single Pod with two Containers: an NGINX webserver and an empty Busybox image.

`cat pod-two-containers-no-volumes.yaml`{{execute}}

Send the spec to the kubernetes cluster with kubectl:

`kubectl apply -f pod-two-containers-no-volumes.yaml`{{execute}}

`kubectl get pods`{{execute}}

If the Pod is in any state other than `Ready`, wait and retry the `get pods` command until all the Containers are up and running.

```
NAME                            READY   STATUS    RESTARTS   AGE
pod-two-containers-no-volumes   2/2     Running   0          29s
```

Once the Pod is Ready, take a closer look using the `kubectl describe` command:

`kubectl describe pod pod-two-containers-no-volumes`{{execute}}

You can see in the `kubectl describe` output that Kubernetes has started two containers, `webserver` and `shell`

```yaml
Name:               pod-two-containers-no-volumes
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node01/172.17.0.38
Start Time:         Wed, 03 Jun 2020 17:07:16 +0000
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"pod-two-containers-no-volumes","namespace":"default"},"spec":{"contai...
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
  ...
Volumes:
  ...
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Pulling    2m58s  kubelet, node01    Pulling image "nginx"
  Normal  Scheduled  2m58s  default-scheduler  Successfully assigned default/pod-two-containers-no-volumes to node01
  Normal  Pulled     2m53s  kubelet, node01    Successfully pulled image "nginx"
  Normal  Created    2m53s  kubelet, node01    Created container webserver
  Normal  Started    2m53s  kubelet, node01    Started container webserver
  Normal  Pulling    2m53s  kubelet, node01    Pulling image "centos"
  Normal  Pulled     2m46s  kubelet, node01    Successfully pulled image "centos"
  Normal  Created    2m46s  kubelet, node01    Created container shell
  Normal  Started    2m46s  kubelet, node01    Started container shell
```

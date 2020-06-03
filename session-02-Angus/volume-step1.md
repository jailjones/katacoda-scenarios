# Lab 1: Pods and Containers

![Peas in a Pod 2](./assets/wood-pea-pod-2.jpg)

## Goals of this lab:

1. Deploy a Pod with two Containers
1. Communicate between the two Containers using `localhost`
1. Configure the two Containers to use a shared Volume
1. Communicate between the two Containers using the Volume

## 1. Deploy a Pod with two Containers

Examine the pod-emptyDir-volume.yaml file. It contains the definition of a single Pod with two Containers: an NGINX webserver and an empty Busybox image.

`cat pod-emptyDir-volume.yaml`{{copy}}

Send the spec to the kubernetes cluster with kubectl:

`kubectl apply -f pod-emptyDir-volume.yaml`{{copy}}

`kubectl get pods`{{copy}}

`kubectl describe pod pod-emptyDir-volume`{{copy}}

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

## 2. Investigate the Containers

### 2a. Webserver

Examine the NGINX logs with:

`kubectl logs pod-two-containers-no-volumes -c webserver`{{copy}}

Now enter the NGINX container by using `kubectl exec` to start a new bash shell:

`kubectl exec pod-two-containers-no-volumes -c webserver -it -- /bin/bash`{{copy}}

In Katacoda the prompt should change from `master $` to `root@pod-two-containers-no-volumes:` while you're inside the container.

Inside the container, use `curl` to see the default content from the webserver:

`curl localhost:80`{{copy}}

You'll see the default NGINX html page. Let's modify that page and confirm that NGINX sees the changes:

`cd /usr/share/nginx/html`{{copy}}

`cat index.html`{{copy}}

`echo "hacked by the tiger team" > index.html`{{copy}}

`curl localhost:80`{{copy}}

After confirming that NGINX is now serving your custom content, go ahead and return to the katacoda root shell with `exit`{{execute}}:

`exit`{{execute}}

### 2b. Shell

The centos image is a plain Linux environment which we'll use to simulate a component interacting with the webserver. Start a bash terminal with `kubectl exec`:

`kubectl exec pod-two-containers-no-volumes -c shell -it -- /bin/bash`{{copy}}

Different Containers in the same Pod don't share the same filesystem. Confirm that the entire `/usr/share/nginx` directory doesn't exist, because NGINX isn't installed on the base centos image:

`ls /usr/share/nginx`{{execute}}

The different Containers DO share the same localhost network, so we can reach the webserver. Confirm that curl still works in the shell container:

`curl localhost:80`{{execute}}

## Onward

![Peas in a Pod 2](./assets/wood-pea-pod-3.png)

You've now seen how Containers communicate by default. Continue to step 2 to learn about Volumes.
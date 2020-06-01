# Lab 1: Pods and Containers

![Peas in a Pod 2](./assets/wood-pea-pod-3.png)

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

`kubectl get pods`

`kubectl describe pod pod-emptyDir-volume`

You can see in the `kubectl describe` output that Kubernetes has started two containers:

## 2. Investigate the Containers

### 2a. Webserver

Examine the NGINX logs with:

`kubectl logs pod-emptyDir-volume -c webserver`

Enter the NGINX container using exec:

`kubectl TODO pod-emptyDir-volume -c webserver bash -l`

### 2b. Shell

The busybox image is a minimal Linux shell, which we'll use for debugging:

`kubectl logs pod-emptyDir-volume -c shell`

## 3. Connect the Containers with a Volume

TODO

## 4. Confirm the two Containers are communicating

TODO

## 5. Complete

![Peas in a Pod](./assets/old-ad-peas.jpg)

Congratulations, you're done!
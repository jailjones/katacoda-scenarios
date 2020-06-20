Examine the pod-emptyDir-volume.yaml file. This contains the same configuration for a Pod with two Containers, but a Volume has been added and configured for both Containers.

`cat pod-emptyDir-volume.yaml`{{execute}}

Send the spec to the kubernetes cluster with kubectl:

`kubectl apply -f pod-emptyDir-volume.yaml`{{execute}}

`kubectl get pods`{{execute}}

If the Pod is in any state other than `Ready`, wait and retry the `get pods` command until all the Containers are up and running.

```
NAME                            READY   STATUS    RESTARTS   AGE
pod-emptyDir-volume   2/2     Running   0          29s
```

Once the Pod is Ready, take a closer look using the `kubectl describe` command:

`kubectl describe pod pod-emptyDir-volume`{{execute}}

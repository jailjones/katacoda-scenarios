Examine the provided spec-pod-with-volume.yaml file:

`cat spec-pod-with-volume.yaml`{{execute}}

This spec contains the same configuration for a Pod with two Containers, but a Volume has been added and configured to attach to both Containers.

Note that each Container will use the same Volume, but with different paths. The NGINX Container will mount the Volume at `/usr/share/nginx/html`, which means that NGINX will serve content from the root of the Volume. Additionally, the shell Container has a command to initialize the Volume with a simple index.html file.

Send the spec to the kubernetes cluster with kubectl:

`kubectl apply -f spec-pod-with-volume.yaml`{{execute}}

Now examine the newly-created pods:

`kubectl get pods`{{execute}}

If the Pod is in any state other than `Running`, wait and retry the `get pods` command until all the Containers are up and running.

```
NAME                            READY   STATUS  RESTARTS   AGE
pod-with-volume                 2/2     Running 0          12s
```

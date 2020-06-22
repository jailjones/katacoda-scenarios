`kubectl` is the CLI tool you use to control a Kubernetes cluster and the apps installed on it. The subcommand `kubectl apply` is used to upload a spec file to the cluster. Send our Pod spec up to the cluster:

`kubectl apply -f spec-pod-2containers.yaml`{{execute}}

Now examine the newly-created pods:

`kubectl get pods`{{copy}}

If the Pod is in any state other than `Running`, wait and retry the `get pods` command until all the Containers are up and running.

```
NAME                            READY   STATUS              RESTARTS   AGE
two-containers                  0/2     ContainerCreating   0          12s
```

Remember, the Kubernetes controller compares the _current state_ of the cluster with the _requested spec_, and tries to create and destroy resources until the former matches the latter. The initial upload of the spec file takes no time because it doesn't wait for this process; it just uploads the requested spec and returns. You therefore have to wait for the Kubernetes controller to detect the changed spec and start creating the new resources.

`kubectl get pods`{{execute}}

```
NAME                            READY   STATUS    RESTARTS   AGE
two-containers                  2/2     Running   0          29s
```

By bundling Containers and Volumes into a single object - the Pod - kubernetes provides a flexible base for any kind of application to be deployed to a cluster.

Building on the atomic Pod, the next layer in the Kubernetes API is Pod controllers such as ReplicaSets and Deployments. Controllers take care of these common responsibilities so that Pods don't have to:

- Keeping track of large fleets of Pods
- Detecting and replacing failing Pods
- Scaling Pod fleets up and down according to demand
- Deploying new versions of specs into a live fleet

We'll investigate Pod controllers and their powers thoroughly in the next section.

![Volume](./assets/wood-pea-pod-3.png)

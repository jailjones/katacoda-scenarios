# Pods

Pods are the core abstraction of Kubernetes. Pods are named for "peas in a pod", because each Pod can contain multiple running images, called _Containers_. A single Pod might contain several Containers, each forming one component of a larger app.

For example, a Pod containing a webapp might have several containers:

- One Container for the backend MySQL database
- A second Container for an NGINX frontend web server
- Several other Containers for microservices to link the frontend and backend.

Of course, you can also deploy a Pod with just one Container, when that is appropriate for your architecture.

## Pod Scaling

The official Kubernetes docs say:

> Each Pod is meant to run a single instance of a given application. If you want to scale your application horizontally (to provide more overall resources by running more instances), you should use multiple Pods, one for each instance.

Thus, when developing a new app you should design your Pod so it can be horizontally scaled.

## Collections of Pods

### ReplicaSets

Pods themselves *don't* deal with issues such as autoscaling, self-healing, or upgrade rollouts. Those are handled by abstractions built on top of Pods: ReplicaSets and Deployments. A ReplicaSet manages several identical Pods and handles autoscaling and self-healing. When the ReplicaSet detects that one of its Pod is unhealthy or unreachable, the ReplicaSet starts a brand new Pod to replace the old one.

### Deployments

Deployments, in turn, manage ReplicaSets. When you submit an updated Pod spec to the Deployment in kubernetes, the Deployment starts a new ReplicaSet with the new Pod spec. After the new ReplicaSet becomes healthy, the Deployment begins serving from the new ReplicaSet, and deletes the previous one.

Using these abstractions allows Pods to ignore most of their own lifecycle. Once a Pod is started on a particular Node, the Pod and all its Containers will remain there for their entire lifecycle. Upgrading Pods and fixing broken Pods both involve starting a brand new Pod from scratch.

> Although Pods are the core abstraction of Kubernetes, when working with Kubernetes you will usually create and manage Deployments rather than individual Pods.

## Communication between Containers

All the Containers in a single Pod can access each other via ports on `localhost` with no configuration.

Communication between different Pods requires configuring a kubernetes Service, which behaves somewhat like both a DNS entry and a firewall rule.

## Volumes

By default the Containers in a Pod have separate filesystems, to prevent them from interfering with each other. By using a Volume you can designate a shared storage mount for a Container. Each Container in the same Pod that is also configured with Volume storage can then see and interact with the same files.

An example from the official docs: you might have a Container that acts as a web server for files in a shared Volume, and a separate "sidecar" Container that updates those files from a remote source, as in the following diagram:

![Volume](/k8s-workshop/scenarios/session-02-core-concepts/assets/volume-example.png)

The separate Containers can be given different security permissions and hardening: the web server should only have read access to the shared Volume, while the updater can write to the shared Volume but can't affect anything else in the web server's Container.

## PersistentVolumes

Pods and their Containers use ephemeral storage by default: any files you edit or save in a Container will be lost once the Container shuts down. 

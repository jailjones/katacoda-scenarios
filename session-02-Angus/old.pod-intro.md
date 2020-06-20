# Pods

![Peas in a Pod 1](./assets/wood-pea-pod-1.png)

Pods are the core abstraction of Kubernetes. Pods are named for "peas in a pod", because each Pod can contain multiple running images, called _Containers_. A single Pod might contain several Containers, each forming one component of a larger app.

For example, a Pod containing a webapp might have several containers:

- One Container for the backend MySQL database
- A second Container for an NGINX frontend web server
- Several other Containers for microservices to link the frontend and backend.

Of course, you can also deploy a Pod with just one Container, when that is appropriate for your architecture.

---

## Pod Scaling

![Peas in a Pod 2](./assets/two-peapods.jpg)

The official Kubernetes docs say:

> Each Pod is meant to run a single instance of a given application. If you want to scale your application horizontally (to provide more overall resources by running more instances), you should use multiple Pods, one for each instance.

Thus, when developing a new app you should design your Pod so it can be horizontally scaled.

---

## Collections of Pods

### ReplicaSets

Pods themselves *don't* deal with issues such as autoscaling, self-healing, or upgrade rollouts. Those are handled by abstractions built on top of Pods: ReplicaSets and Deployments. A ReplicaSet manages several identical Pods and handles autoscaling and self-healing. When the ReplicaSet detects that one of its Pod is unhealthy or unreachable, the ReplicaSet starts a brand new Pod to replace the old one.

### Deployments

Deployments, in turn, manage ReplicaSets. When you submit an updated Pod spec to the Deployment in kubernetes, the Deployment starts a new ReplicaSet with the new Pod spec. After the new ReplicaSet becomes healthy, the Deployment begins serving from the new ReplicaSet, and deletes the previous one.

Using these abstractions allows Pods to ignore most of their own lifecycle. Once a Pod is started on a particular Node, the Pod and all its Containers will remain there for their entire lifecycle. Upgrading Pods and fixing broken Pods both involve starting a brand new Pod from scratch.

> Although Pods are the core abstraction of Kubernetes, when working with Kubernetes you will usually create and manage Deployments rather than individual Pods.

---

# Inside the Pod

## Communication between Containers

All the Containers in a single Pod can access each other via ports on `localhost` with no configuration.

Communication between different Pods requires configuring a kubernetes Service, which behaves somewhat like both a DNS entry and a firewall rule.

---

# Lab: inter-Pod communication

---

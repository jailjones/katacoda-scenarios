## Let's see this in action...

Let's consider the following scenario:
- You have a Deployment with a container on version 1 and three replicas.
- You change the spec for your template and upgrade your container from version 1 to version 2.

The ReplicaSet can hold only a single type of Pod, so you can't have version 1 and version 2 of the Pods in the same ReplicaSet.

The Deployment knows that the two Pods can't coexist in the same ReplicaSet, so it creates a second ReplicaSet to hold version 2.

Then gradually it decreases the count of replicas from the previous ReplicaSet and increases the count on the current one until the latter ReplicaSet has all the Pods.

In other words, the sole responsibility for the ReplicaSet is to count Pods.

Instead, the Deployment manages ReplicaSets and orchestrates the rolling update. Let's visualize this first before we create our own Deployments.

---

## Deployments create ReplicaSets that create Pods
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-2.png)

---

## Can you have two different Pods in the same ReplicaSet?
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-3.png)

---

## ReplicaSets can only contain a single type of Pod. You can't use two different Docker images. How can you deploy two versions of the app simultaneously?
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-4.png)

---

## The Deployment knows that you can't have different Pods in the same ReplicaSet. So it creates another ReplicaSet
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-5.png)

---

## It increases the number of replicas of the current ReplicaSet to one
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-6.png)

---

## And then it proceeds to decrease the replicas count in the previous ReplicaSet
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-7.png)

---

## The same process of increasing and decreasing Pods continues until all Pods are created on the current ReplicaSet
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-8.png)

---

## Please notice how you have two Pods templates and two ReplicaSets
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-9.png)

---

## Also, the traffic is hitting both the current and previous version of the app
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-10.png)

---

## After the rolling update is completed, the previous ReplicaSet is NOT deleted
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-replicaset-11.png)

---

# How about we see this in action?
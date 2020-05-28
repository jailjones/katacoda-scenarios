## What happens when you create a Deployment?

Kubernetes and kubectl offer a simple mechanism to roll back changes to resources such as Deployments, StatefulSets and DaemonSets.

But before talking about rollbacks, you should learn an important detail about Deployments.

You learned how Deployments are responsible for gradually rolling out new versions of your Pods without causing any downtime.

You are also familiar with the fact that Kubernetes watches over the number of replicas in your deployment.

If you asked for 5 Pods but have only 4, Kubernetes creates one more.

If you asked for 4 Pods, but you have 5, Kubernetes deletes one of the running Pods.

Since the replicas is a field in the Deployment, you might be tempted to conclude that is the Deployment's job to count the number of Pods and create or delete them.

This is not the case, unfortunately. Deployments delegate counting Pods to another component: the **ReplicaSet**

---

Every time you create a Deployment, the deployment creates a ReplicaSet and delegates creating (and deleting) the Pods. So let's remember that Deployments don't create Pods. ReplicaSets do.

## Let's focus on a Deployment
![Replica Set 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/replicaset-2.png)

---

## You might be tempted to think that Deployments are in charge of creating Pods
![Replica Set 3](/k8s-workshop/scenarios/session-02-core-concepts/assets/replicaset-3.png)

---

## The Deployment doesn't create Pods. Instead it creates another object called ReplicaSet
![Replica Set 4](/k8s-workshop/scenarios/session-02-core-concepts/assets/replicaset-4.png)

---

## The Deployment passes the spec (which includes the replicas) to the ReplicaSet
![Replica Set 5](/k8s-workshop/scenarios/session-02-core-concepts/assets/replicaset-5.png)

---

## The ReplicaSet is in charge of creating the Pods and watching over them
![Replica Set 6](/k8s-workshop/scenarios/session-02-core-concepts/assets/replicaset-6.png)

---

But why isn't the Deployment creating the Pods?

Why does it have to delegate that task to someone else? That's a good question, to help answer it, we must first understand what the **ReplicaSet** object is.

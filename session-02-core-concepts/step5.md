### We recommend that you type out the commands to become more familiar with `kubectl` but you can also copy them to save time!
### If you're feeling stuck with `kubectl` don't forget about the `-h` `--help` swtich

Let's apply this ReplicaSet:

```yml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: k8s-bootcamp-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      name: app
  template:
    metadata:
      labels:
        name: app
    spec:
      containers:
      - name: app
        image: learnk8s/hello:1.0.0
```

By running this kubectl command:

`kubectl apply -f replica-set-v1.yml`{{copy}}

Let's get some information about the ReplicaSet we just deployed:

> The below command lists all ReplicaSets in the current Namespace.

`kubectl get replicasets`{{copy}}

Take note of the name.

---

What happens when we apply another ReplicaSet with the same name but increment the image version?

`learnk8s/hello:1.0.0` -> `learnk8s/hello:2.0.0`

```yml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: k8s-bootcamp-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      name: app
  template:
    metadata:
      labels:
        name: app
    spec:
      containers:
      - name: app
        image: learnk8s/hello:2.0.0
```

Let's run the following command:

`kubectl apply -f replica-set-v2.yml`{{copy}}

And then get information about existing ReplicaSets?

`kubectl get replicaset k8s-bootcamp-replicaset`{{copy}}

If you compare the names you will see that they are the same. This is because when the new version of the application was deployed via ReplicSets the Pods were replaced and no history of our previous deploys has been kept. The ReplicaSet can hold only a single type of Pod, so you can't have version 1 and version 2 of the Pods in the same ReplicaSet. **Even though you can deploy applications using ReplicaSets this is not recommended and a Deployment should always be used to keep track of ReplicaSets.**

---

There's something else worth noting about the ReplicaSets and Deployments.

When you upgrade your Pods from version 1 to version 2, the Deployment creates a new ReplicaSet and increases the count of replicas while the previous count goes to zero.

After the rolling update, the previous ReplicaSet is not deleted — not immediately at least.

Instead, it is kept around with a replicas count of 0.

If you try to execute another rolling update from version 2 to version 3, you might notice that at the end of the upgrade, you have two ReplicaSets with a count of 0.

Why are the previous ReplicaSets not deleted or garbage collected?

Imagine that the current version of the container introduces a regression.

You probably don't want to serve unhealthy responses to your users, so you might want to roll back to a previous version of your app.

If you still have an old ReplicaSet, perhaps you could scale the current replicas to zero and increment the previous ReplicaSet count.

In other words, keeping the previous ReplicaSets around is a convenient mechanism to roll back to a previously working version of your app.

**By default Kubernetes stores the last 10 ReplicaSets and lets you roll back to any of them.**

But you can change how many ReplicaSets should be retained by changing the `spec.revisionHistoryLimit` in your Deployment.
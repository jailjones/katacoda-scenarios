Let's quickly pull some information on our previous Deployment:

`kubectl get deployment k8s-bootcamp-deployment -o yaml | yh`{{copy}}

Then let's also list out the ReplicaSets that we have:

`kubectl get replicasets`{{copy}}

We should be seeing the ReplicaSet we deployed in **Step 2** along with the ReplicaSet that's managed by our Deployment in **Step 3**.

Let's bump the version of our deployed application by applying another Deployment `image: learnk8s/hello:1.0.0` --> `image: learnk8s/hello:2.0.0`

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: k8s-bootcamp-deployment
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 25%
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

`kubectl apply -f deployment-v2.yaml`{{copy}}

Now let's check our ReplicaSets, and see if you notice something different?

`kubectl get replicasets`{{copy}}

We should now see an additional ReplicaSet that's managed by our Deployment. Awesome! Let's deploy another version of our application.

This time we're bumping from `image: learnk8s/hello:2.0.0` --> `image: learnk8s/hello:3.0.0`

`kubectl apply -f deployment-v3.yaml`{{copy}}

Once again, let's check our ReplicaSets:

`kubectl get replicasets`{{copy}}

Now we should have 3 total ReplicaSets managed by our Deployment.

What's happening here? There's something else worth noting about the ReplicaSets and Deployments.

- When you upgrade your Pods from version 1 to version 2, the Deployment creates a new ReplicaSet and increases the count of replicas while the previous count goes to zero.
- After the rolling update, the previous ReplicaSet is not deleted — not immediately at least.
  - Instead, it is kept around with a replicas count of 0.
- If you try to execute another rolling update from version 2 to version 3, you might notice that at the end of the upgrade, you have two ReplicaSets with a count of 0.
- Why are the previous ReplicaSets not deleted or garbage collected?
- Imagine that the current version of the container introduces a regression.
  - You probably don't want to serve unhealthy responses to your users, so you might want to roll back to a previous version of your app.
  - If you still have an old ReplicaSet, perhaps you could scale the current replicas to zero and increment the previous ReplicaSet count.
- In other words, keeping the previous ReplicaSets around is a convenient mechanism to roll back to a previously working version of your app.
- By default Kubernetes stores the last 10 ReplicaSets and lets you roll back to any of them.
  - But you can change how many ReplicaSets should be retained by changing the `spec.revisionHistoryLimit` in your Deployment.

Now that we the knowledge, let's take a look at our last Deployment one more time:

`kubectl get deployment k8s-bootcamp-deployment -o yaml | yh`{{copy}}


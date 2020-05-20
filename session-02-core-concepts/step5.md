Let's quickly pull some information on an existing Deployment:

`kubectl get deployment k8s-bootcamp-deployment -o yaml | yh`{{copy}}

Then let's also list out the ReplicaSets that we have:

`kubectl get replicasets`{{copy}}

We should be seeing the ReplicaSet we deployed in **Step 2** along with the ReplicaSet that's managed by our Deployment in **Step 3**

---

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

Let's remember how our ReplicaSet looked like:

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

For reference, this is a Deployment that creates the ReplicaSet above:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: k8s-bootcamp-deployment
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

Aren't those the same? In this example, almost!

However, in a Deployment, you can define properties such how many Pods to create and destroy during a rolling update (the field is `strategy:`). Deployments, by default, employ the RollingUpdate strategy. In general, the YAML for the Deployment contains the ReplicaSet plus some additional details.

The same property isn't available in the ReplicaSet. Let's take a look at the example below, this is how the default strategy looks if we were to explicitly define it.

> How do you know which properties are available? [You can reference the official K8s API](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#deployment-v1-apps)

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
        image: learnk8s/hello:1.0.0
```

Let's understand what the fields under `strategy.type.rollingUpdate` indicate.

```yml
  strategy:
    type: RollingUpdate
    rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 25%  
```

`.spec.strategy.rollingUpdate.maxUnavailable` is an optional field that specifies the maximum number of Pods that can be unavailable during the update process. 

`.spec.strategy.rollingUpdate.maxSurge` is an optional field that specifies the maximum number of Pods that can be created over the desired number of Pods

---

Alright, let's create a deployment we listed above, keep in mind we're choosing not to explicity define the `strategy` and are instead letting Kubernetes apply the defaults.

> **NOTE:** If you're curious you can `cat` the deployment.yml and see exactly what we're applying `cat deployment.yml`

`kubectl apply -f deployment.yaml`{{copy}}

Now, let's get some information about the ReplicaSet we just deployed (this command will list all Deployments, but if there's only 1 available, K8s will get some additional details):

`kubectl get deployments`{{copy}}

More detail:

`kubectl get replicaset k8s-bootcamp-deployment -o yaml | yh`{{copy}}

What are some of the things that you noticed? How about `spec.revisionHistoryLimit`? By default Kubernetes stores the last `10` ReplicaSets and lets you roll back to any of them. But you can change how many ReplicaSets should be retained by changing the `spec.revisionHistoryLimit` in your Deployment.
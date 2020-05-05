### Before we start
- **We recommend that you type out the commands to become more familiar with `kubectl` but you can also copy them to save time!**
- **If you're feeling stuck with `kubectl` don't forget about the `-h` `--help` swtich**
- **Since we're not specifing a Namespace, all commands and objects created are ran against the `default` Namespace**
- **We have added a YAML highlighter to make it easier to read outputs, this is not included by default**
  - **You will recodnize it's usage after a pipe, like so ` | yh`**

A ReplicaSet ensures that a specified number of pod replicas are running at any given time. The ReplicaSet can hold only a single type of Pod, so you can't have version 1 and version 2 of the Pods in the same ReplicaSet.

But what if you don't care about rolling updates and only wish for your Pods to be recreated when they are deleted?

Could you create a ReplicaSet without a Deployment?

Of course, you can.

Here's an example of a ReplicaSet:

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

Let's understand a few concepts before proceeding:

- `replicas` describes how many pods this deployment should have. In our case, there will be 3 pods created
- `template` describes how each pod should look like. It describes a list of containers that should be in the Pod
- `selector` determines which pods are considered to be part of this ReplicaSet

Let's apply it!

> **NOTE:** If you're curious you can `cat` the deployment.yml and see exactly what we're applying `cat deployment.yaml | yh`{{copy}}

`kubectl apply -f replica-set-v1.yaml`{{copy}}

Now, let's get some information about the ReplicaSet we just deployed:

`kubectl get replicasets`{{copy}}

More detail:

`kubectl get replicaset k8s-bootcamp-replicaset -o yaml | yh`{{copy}}

You'll likely notice some interesting tidbits, but don't worry, we'll likely cover these in the following sections, and if we don't please ask us questions.

Remember that a ReplicaSet can hold only a single type of Pod, so you can't have version 1 and version 2 of the Pods in the same ReplicaSet. 

---

What if you wanted to get some more additional information on this ReplicaSet, there's a useful `kubectl` command that will give you additional information on almost any type of resource: `describe`

`kubectl describe replicaset k8s-bootcamp-replicaset | yh`{{copy}}

**Even though you can deploy applications using ReplicaSets this is not recommended and a Deployment should always be used to keep track of ReplicaSets.**

Now that we're more familiar with ReplicaSets let's revisit Deployments.

# Roll it back!

How do we check previous ReplicaSets directly tied with our Deployment??

You can use the following command to inspect the history of your Deployment:

`kubectl rollout history deployment/k8s-bootcamp-deployment`{{copy}}

We see 3 Revisions of our deployment, let's verify that the last revision is indeed the wrong image:

`kubectl rollout history deployment/k8s-bootcamp-deployment --revision=3`{{copy}}

You should see:

```
master $ kubectl rollout history deployment/k8s-bootcamp-deployment --revision=3
deployment.extensions/k8s-bootcamp-deployment with revision #3
Pod Template:
  Labels:       name=app
        pod-template-hash=576bc6648f
  Containers:
   app:
    Image:      gcr.io/google-samples/hello-go-gke:1.0
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
```

```yml
Image:      gcr.io/google-samples/hello-go-gke:1.0
```

---

How does the Deployment know their ReplicaSets? Does it store the order in which ReplicaSets are created?

The ReplicaSets have random names with ID such as k8s-bootcamp-deployment-2aa66c4371, so you should expect the Deployment to store a reference to them.

Let's inspect the Deployment with:

`kubectl get deployment k8s-bootcamp-deployment -o yaml | yh`{{copy}}

Nothing is looking like a list of previous 10 ReplicaSets. Deployments don't hold a reference to their ReplicaSets in the same YAML. Instead, related ReplicaSets are retrieved comparing the template section in YAML. Remember when you learned that Deployments are ReplicaSets with some extra features? Kubernetes uses that information to compare Deployments and ReplicaSets and make sure that they are related.

What about the order? How do you know which one was the last ReplicaSet used? Or the third? Kubernetes stores the revision in the `ReplicaSet.metatada.annotation.` field

You can inspect the revision with (replacing xxxxxxxx with a random ID of one of your ReplicaSets):

`kubectl get replicasets`{{copy}}

`kubectl get replicaset k8s-bootcamp-replicaset k8s-bootcamp-deployment-xxxxxxxx -o yaml | yh`{{copy}}

So, what happens when you find a regression in the current release and decide to rollback to version 2 like so:

`kubectl rollout undo deployment/k8s-bootcamp-deployment --to-revision=2`{{copy}}

- Kubectl finds the ReplicaSets that belong to the Deployment
- Each ReplicaSet has a revision number. Revision 2 is selected
- The current replicas count is decreased, and the count is gradually increased in the ReplicaSet belonging to revision 2
- The `deployment.kubernetes.io/revision` annotation is updated. The current ReplicaSet changes from revision 2 to 4

Let's check the history one more time:

`kubectl rollout history deployment/k8s-bootcamp-deployment`{{copy}}

```
master $ kubectl rollout history deployment/k8s-bootcamp-deployment
deployment.extensions/k8s-bootcamp-deployment
REVISION  CHANGE-CAUSE
1         <none>
3         <none>
4         <none>
```

If before the undo you had three ReplicaSets with revision 1, 2 and 3, now you should have 1, 3 and 4. There's a missing entry in the history: the revision 2 that was promoted to 4.

---

_There's also something else that looks useful but doesn't work quite right._

The history command displays two columns: _Revision_ and _Change-Cause_.

```terminal|command=1|title=bash
kubectl rollout history deployment/k8s-bootcamp-deployment
REVISION  CHANGE-CAUSE
1         <none>
3         <none>
4         <none>
```

While you're now familiar with the Revision column, you might be wondering what Change-Cause is used for — and why it's always set to `<none>`.

When you create a resource in Kubernetes, you can append the `--record` flag like so:

`kubectl apply -f deployment-v1.yaml --record`{{copy}}

When you do, Kubernetes adds an annotation to the resource with the command that generated it.

In the example above, the Deployment has the following metadata section:

```yml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "4"
    kubectl.kubernetes.io/last-applied-configuration: |
      ......
    kubernetes.io/change-cause: kubectl apply --filename=deployment-v1.yaml --record=true
  creationTimestamp: "2020-05-28T00:38:47Z"
  generation: 5
  name: k8s-bootcamp-deployment
  namespace: default
  resourceVersion: "18562"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/k8s-bootcamp-deployment
  uid: 979c1d36-a07b-11ea-8f9f-0242ac11003a
```

Notice the change-cause annotation:

```yml
kubernetes.io/change-cause: kubectl apply --filename=deployment-v1.yaml --record=true
```

Now, if you try to display the history again, you might notice that the same annotation is used in the rollout history command:

`kubectl rollout history deployment/k8s-bootcamp-deployment`{{copy}}

---

The `--record` command can be used with any resource type, but the value is only used in Deployment, DaemonSet, and StatefulSet resources, i.e. resources that can be "rolled out" (see `kubectl rollout -h`).

But you should remember:

- The `--record` flag adds an annotation to the YAML resource, which can be changed at any time
- The rollout history command uses the value of this annotation to populate the Change-Cause table
- The annotation contains the last command only. If you create the resource and later use `kubectl scale --replicas=10 deploy/app --record` to scale it, only the scaling command is stored in the annotation.

Also, there is an [ongoing discussion on deprecating the `--record` flag](https://github.com/kubernetes/kubernetes/issues/40422).

The feature provides little value for manual usage, but it still has some justification for automated processes as a simple form of auditing (keeping track of which commands caused which changes to a rollout).

### That's it! Good job on completing this lab and we hope it has armed you with the fundamental knowledge to understand Deployments in Kubernetes :)
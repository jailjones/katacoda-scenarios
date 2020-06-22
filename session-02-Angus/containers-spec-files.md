Examine the spec-pod-2containers.yaml file that has been provided:

`cat spec-pod-2containers.yaml`{{execute}}

This is a Kubernetes spec file, which tells Kubernetes about the _requested state_ . At the top you can see some standard keys for spec files:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: two-containers
spec:
  ...
```

Inside this particular Pod spec, you should be able to see two entries under the `containers:` key, each with a `image:` property describing a docker image to run. Therefore each install of this Pod will spin up two docker containers.

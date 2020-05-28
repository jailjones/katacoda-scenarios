# Secrets

A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in an image. Users can create secrets and the system also creates some secrets.

To use a secret, a Pod needs to reference the secret. A secret can be used with a Pod in two ways:

- As files in a volume mounted on one or more of its containers.
- By the kubelet when pulling images for the Pod.

In this lab, we are going to create and mount secrets in your K8s cluster

1. Lets create a new namespace

    `kubectl create namespace secret-example`{{execute}}

2. Create the secret 

    `kubectl create secret generic dev-db-secret --from-literal=username=devuser --from-literal=password='p@ssw0rd1234' --namespace secret-example`{{execute}}

3. List your secret

    `kubectl get secrets -n secret-example`{{execute}}

    `kubectl describe secrets/dev-db-secret -n secret-example`{{execute}}

```
Note: The commands kubectl get and kubectl describe avoid showing the contents of a secret by default. This is to protect the secret from being exposed accidentally to an onlooker, or from being stored in a terminal log.
```

## Now lets mount a secret as a volume for a pod to use

4. Create a `secret-pod.yaml` file and copy the following data

    `vim secret-pod.yaml`{{execute}}

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-test-pod
  namespace: secret-example
spec:
  containers:
    - name: test-container
      image: nginx
      volumeMounts:
        # name must match the volume name below
        - name: secret-volume
          mountPath: /etc/secret-volume
  # The secret data is exposed to Containers in the Pod through a Volume.
  volumes:
    - name: secret-volume
      secret:
        secretName: dev-db-secret
```

### Note: Ensure you copy correctly, yaml file are very specific in spacing!

5. Create the pod

    `kubectl apply -f ./secret-pod.yaml`{{execute}}

    And verify it is running

    `kubectl get pod secret-test-pod`{{execute}}

6. Get a shell into the container that is running in your pod

    `kubectl exec -it secret-test-pod -- /bin/bash`{{execute}}

7. The secret data is exposed to the Container through a Volume mounted under `/etc/secret-volume`. In your shell, go to the directory where the secret data is exposed

    root@secret-test-pod:/# `cd /etc/secret-volume`

8. In the shell, list the files in `/etc/secret-volume`

    root@secret-test-pod:/etc/secret-volume# `ls`

    And you should see the output of the secret created
    - Username
    - Password

9. Exit out of the shell and delete the pod

    `kubectl delete -f ./secret-pod.yaml`{{execute}}

## Next we will show how to use environment variables for secrets if mounting a volume is not an option

10. Let us create a 2 secrets to show how to handle multiple secrets

    `kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'`{{execute}}

    `kubectl create secret generic db-user --from-literal=db-username='db-admin'`{{execute}}

11. Let us create another file labeled `pod-multi-secret-env-variable.yaml`

    `vim pod-multi-secret-env-variable.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: envvars-multiple-secrets
spec:
  containers:
  - name: envars-test-container
    image: nginx
    env:
    - name: BACKEND_USERNAME
      valueFrom:
        secretKeyRef:
        # Is the name of the 1st secret we created in step 10
          name: backend-user
          key: backend-username
    - name: DB_USERNAME
      valueFrom:
        secretKeyRef:
        # Is the name of the 2nd secret we created in step 10
          name: db-user
          key: db-username
```
Notice how under `spec.containers` we have 2 name paths in our yaml to point to both secrets we created. The names `BACKEND_USERNAME` and `DB_USERNAME` will be the literal env variables names exported to the container's environment.

If we were to put an actual password as an environment variable...then you could see actual output of a password in your terminal. Hence why we highly recommend using volumes to store secrets versus environment variables whenever possible.

12. Now create the pod

    `kubectl create -f ./pod-multi-secret-env-variable.yaml`{{execute}}

Notice in the pod's creation output shows the 2 environment variables for the usernames we want the pods to use.

13. Delete the pods

    `kubectl delete -f ./pod-multi-secret-env-variable.yaml`{{execute}}

14. Done



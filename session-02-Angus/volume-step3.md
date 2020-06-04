
# 3. Use the webserver from the shell

The centos image is a plain Linux environment which we'll use to simulate a component interacting with the webserver. Start a bash terminal with `kubectl exec`:

`kubectl exec pod-two-containers-no-volumes -c shell -it -- /bin/bash`{{execute}}

Different Containers in the same Pod don't share the same filesystem. Confirm that the entire `/usr/share/nginx` directory doesn't exist, because NGINX isn't installed on the base centos image:

`ls /usr/share/nginx`{{execute}}

The different Containers DO share the same localhost network, so we can reach the webserver. Confirm that curl still works in the shell container:

`curl localhost:80`{{execute}}

## Onward

![Peas in a Pod 2](./assets/wood-pea-pod-3.png)

You've now seen how Containers communicate by default. Continue to step 2 to learn about Volumes.
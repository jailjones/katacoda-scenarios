Let's dig deeper into the webserver Container.

## kubectl logs

When a docker image starts there is either an `ENTRYPOINT` or a `Command` that is the image's executable "app". The stdout and stderr logs from that initial execution are available in kubernetes using the `kubectl logs` command:

`kubectl logs two-containers -c webserver`{{copy}}

Because your Pod has multiple Containers, you need to add the  `-c webserver` flag. If your Pod only has a single Container you can skip the -c flag.

## kubectl exec

Examining the logs is great, but what if you need to do more? The extremely powerful `kubectl exec` command lets you run any standard Linux shell command inside the Container, and you can view the stdout and interact with stdin over your remote connection.  In particular, it's possible to open a full interactive bash shell using the `-it` flags and executing `/bin/bash`:

`kubectl exec two-containers -c webserver -it -- /bin/bash`{{copy}}

In Katacoda the prompt should change from `master $` to `root@two-containers:/#` while you're inside the container.

Since docker images aren't meant to be full operating systems, you may not have access to all the standard tools you're used to in your host environment. In particular, you can see that you don't have access to `kubectl` inside the Container:

```
controlplane $ kubectl exec two-containers -c webserver -it -- /bin/bash
root@two-containers:/# kubectl
bash: kubectl: command not found
root@two-containers:/#
```

## NGINX

Inside the Container, use `curl` to see the default content from your NGINX webserver:

`curl localhost:80`{{copy}}

You'll see the default NGINX html page. Let's modify that page and confirm that NGINX sees the changes:

`cd /usr/share/nginx/html`{{copy}}

`cat index.html`{{copy}}

`echo "hacked by the tiger team" > index.html`{{copy}}

`curl localhost:80`{{copy}}

After confirming that NGINX is now serving your custom content

## From outside the Pod

Go ahead and exit the webserver Container, returning to your katacoda root shell.

`exit`{{copy}}

Observe that our webserver is NOT visible from outside of the cluster:

`curl localhost:80`{{copy}}

```
curl: (7) Failed to connect to localhost port 80: Connection refused
```

By default Kubernetes doesn't allow any communication between Pods or from a Pod to the outside of the cluster. Just because you have enough `kubectl` access to `exec` a remote root shell, doesn't mean you can just start connecting to random ports!

In order to access the web server from "outside" the cluster, you would need to configure both a Service for the Pod and an Ingress for the whole cluster. As we'll see in the next step, the other Container in the same Pod _will_ have network access.
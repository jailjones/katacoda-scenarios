Let's examine the webserver Container. Examine the NGINX logs using the `-c webserver` flag to specify the container:

`kubectl logs two-containers -c webserver`{{execute}}

Now enter the NGINX container by using `kubectl exec` with the same container flag to start a new bash shell:

`kubectl exec two-containers -c webserver -it -- /bin/bash`{{execute}}

In Katacoda the prompt should change from `master $` to `root@two-containers:/#` while you're inside the container.

Inside the container, use `curl` to see the default content from the webserver:

`curl localhost:80`{{execute}}

You'll see the default NGINX html page. Let's modify that page and confirm that NGINX sees the changes:

`cd /usr/share/nginx/html`{{execute}}

`cat index.html`{{execute}}

`echo "hacked by the tiger team" > index.html`{{execute}}

`curl localhost:80`{{execute}}

After confirming that NGINX is now serving your custom content, go ahead and return to the katacoda root shell.

`exit`{{execute}}

## From outside the Pod

Observe that our webserver is NOT visible from outside of the cluster:

`curl localhost:80`{{execute}}

```
curl: (7) Failed to connect to localhost port 80: Connection refused
```

By default Kubernetes doesn't allow any communication between Pods or from a Pod to the outside of the cluster. You would need to configure both a Service for the Pod and Ingress the cluster, in order to access the web server. As we'll see in the next step, the other Container in the Pod _will_ have network access.
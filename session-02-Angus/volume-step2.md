
## 2. Investigate the Webserver container

Let's examine the webserver Container. Examine the NGINX logs using the `-c webserver` flag to specify the container:

`kubectl logs pod-two-containers-no-volumes -c webserver`{{execute}}

Now enter the NGINX container by using `kubectl exec` with the same container flag to start a new bash shell:

`kubectl exec pod-two-containers-no-volumes -c webserver -it -- /bin/bash`{{execute}}

In Katacoda the prompt should change from `master $` to `root@pod-two-containers-no-volumes:/#` while you're inside the container.

Inside the container, use `curl` to see the default content from the webserver:

`curl localhost:80`{{execute}}

You'll see the default NGINX html page. Let's modify that page and confirm that NGINX sees the changes:

`cd /usr/share/nginx/html`{{execute}}

`cat index.html`{{execute}}

`echo "hacked by the tiger team" > index.html`{{execute}}

`curl localhost:80`{{execute}}

After confirming that NGINX is now serving your custom content, go ahead and return to the katacoda root shell with `exit`{{execute}}:

`exit`{{execute}}

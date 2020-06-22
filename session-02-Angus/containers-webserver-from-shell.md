
The centos image we used for the shell Container is a plain Linux environment which we'll use to simulate a component interacting with the webserver. Start a bash terminal using `kubectl exec` with the `-c shell` flag:

`kubectl exec two-containers -c shell -it -- /bin/bash`{{copy}}

Different Containers in the same Pod don't share the same filesystem. You can confirm that the entire `/usr/share/nginx` directory doesn't exist, because NGINX isn't installed on the base centos image:

`ls /usr/share/nginx`{{copy}}

The different Containers DO share the same localhost network, so we can reach the webserver from this shell Container. Confirm that curl still works in the shell container, and serves the content you modified in the last step:

`curl localhost:80`{{copy}}

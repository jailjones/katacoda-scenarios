With our two Containers sharing a Volume, we can now modify the webserver from the shell. Start a new bash session in the shell Container:

`kubectl exec pod-with-volume -c shell -it -- /bin/bash`{{execute}}

Confirm that the new Volume is available in the right place:

`ls /opt/shared_volume`{{execute}}

`cat /opt/shared_volume/index.html`{{execute}}

Confirm that you can get the initial content from the webserver Container over `localhost`:

`curl localhost:80`{{execute}}

## Modifying the Content

Now, let's alter the index.html file on our shared drive, and confirm that we see the results across the gap:

`curl localhost:80/doesnt-exist`

`echo "<i>A terrible error message</i>" > /opt/shared_volume/50x.html`{{execute}}

`curl localhost:80/doesnt-exist`

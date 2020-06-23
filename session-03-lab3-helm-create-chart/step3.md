# Improve the Deployment

1. Copy the files from `/usr/local/bin` for **myspringapp3** into **./myspringapp** to add a Service

  `cp -R /usr/local/bin/myspringapp3/* myspringapp/`

## Let't take a look around and see what has changed

1. Chart.yaml

  The version has been changed to 0.3.0

  ```yaml
  apiVersion: v1
  appVersion: "1.0"
  description: A Helm chart for myspringapp
  name: myspringapp
  version: 0.3.0
  ```

1. values.yaml

  A few more values have been added to improve the Deployment

  The **resources** section defines resource requests that the deployment makes when pods are being started on the cluster. The cluster will try to schedule pods on nodes where it can fulfill the CPU and Memory requirements defined here. For example, this deployment is specifying that the pod can start with .1 cores and 128Mb of RAM, but can consume upto .2 cores and 256Mb of RAM, so the control plane in the cluster will only spin up pods of this deployment on nodes where it can fulfill those resource requirements.

  ```yaml
  resources:
    # We usually recommend not to specify default resources and to leave this as a conscious
    # choice for the user. This also increases chances charts run on environments with little
    # resources, such as Minikube. If you do want to specify resources, uncomment the following
    # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
    limits:
     cpu: 200m
     memory: 256Mi
    requests:
     cpu: 100m
     memory: 128Mi
  ```

  Liveness and Readiness probes are used to define the requirements by which a pod can say it is live and then ready to receive traffic. When a pod is live, it will indicate this status to the cluster, but until it is ready, it will not receive any traffic.

  For this Springboot Application, we are using the actuator plugin which returns a simple HTTP 200 response when the service starts up. This endpoint can be accessed on the container port at the /actuator/health path

  We also setup some rules for polling on both liveness and readiness:
  1. Give the service a few seconds to start up
  1. Set a time interval between polls
  1. For liveness, the number of failed polls to consider the pod failed
  1. For readiness, the number of successful responses needed to consider the pod ready to receive traffic

  ```yaml
  livenessProbe:
    path: /actuator/health
    port: 8181
    initialDelaySeconds: 10
    periodSeconds: 10
    failureThreshold: 3

  readinessProbe:
    path:  /actuator/health
    port: 8181
    initialDelaySeconds: 10
    periodSeconds: 10
    successThreshold: 1
  ```

1. templates/deployment.yaml

  Using the templatized configuration afforded by Golang, we make use of the new values in our containers specification

  ```yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: {{ .Chart.Name }}-{{ .Chart.Version }}-deployment
    labels:
      run: {{quote .Values.labels.AppName }}
      app.kubernetes.io/instance: {{ .Release.Name }}
      app.kubernetes.io/managed-by: {{ .Release.Service }}
      AppName: {{quote .Values.labels.AppName }}
      AppVersion: {{quote .Values.labels.AppVersion }}
  spec:
    selector:
      matchLabels:
        run: {{quote .Values.labels.AppName }}
    replicas: {{ .Values.replicaCount }}
    template:
      metadata:
        labels:
          run: {{quote .Values.labels.AppName }}
          AppName: {{quote .Values.labels.AppName }}
          container: app
      spec:
        containers:
          - name: {{quote .Values.labels.AppName }}
            image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
            ports:
              - containerPort:  {{ .Values.image.containerPort }}
            resources:
              {{- toYaml .Values.resources | nindent 12 }}
            livenessProbe:
              httpGet:
                path: {{ .Values.livenessProbe.path }}
                port: {{ .Values.livenessProbe.port }}
              initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
              periodSeconds: {{ .Values.livenessProbe.periodSeconds }}
              failureThreshold: {{ .Values.livenessProbe.failureThreshold }}
            readinessProbe:
              httpGet:
                path:  {{ .Values.readinessProbe.path }}
                port:  {{ .Values.readinessProbe.port }}
              initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds }}
              periodSeconds: {{ .Values.readinessProbe.periodSeconds }}
              failureThreshold: {{ .Values.readinessProbe.failureThreshold }}
  ```

  With these changes, we have improved the overall reliability of our deployment; now, a Pod will only be scheduled to start on nodes that can support its resource requirements and the cluster will validate readiness and liveness of the underlying service before directing traffic to the Pod.

## Package and Install

Prior to upgrading, because we made multiple changes to deployment.yaml, it would be nice to validate that our changes are correct and have the desired effect. For this, we can leverage **dry-run** and **debug**
`helm upgrade myspringapp --dry-run --debug`{{execute}}

If the command returns output without any errors, then your template is valid in terms of formatting.
You can also view the output to ensure it has your desired changes.

---

Lets also get a view of the deployment configuration prior to upgrading the release:
`export DEPLOYMENT_NAME=$(kubectl get deployments --namespace default -l "app.kubernetes.io/instance=myspringapp" -o jsonpath="{.items[0].metadata.name}")`{{execute}}
`kubectl describe deployment $DEPLOYMENT_NAME`{{execute}}

---

Package the chart using **helm package**
`helm package myspringapp`{{execute}}

Check that your chart was packaged correctly
`ls -l`{{execute}}
You should see a file called **myspringapp-0.3.0.tgz**

---

Now you can upgrade your chart
`helm upgrade myspringapp myspringapp-0.3.0.tgz`{{execute}}

---

Verify your chart installed
`helm list`{{execute}}

## Be the change, Own the change

Run the following to view the deployment configuration to see how it has changed
`export DEPLOYMENT_NAME=$(kubectl get deployments --namespace default -l "app.kubernetes.io/instance=myspringapp" -o jsonpath="{.items[0].metadata.name}")`{{execute}}
`kubectl describe deployment $DEPLOYMENT_NAME`{{execute}}

## Congrats!

Congrats, you have now successfully built your own chart from scratch, updated it, and improved it.

# Create chart from scratch

1. Let's initialize an empty directory to house our chart files

  `mkdir myspringapp`{{execute}}

2. Copy the files from `/usr/local/bin` for **myspringapp1** into this empty directory

  `cp -R /usr/local/bin/myspringapp1/* myspringapp/`

## Let't take a look around and see what this chart consists of

1. Chart.yaml

  Defines a Chart for myspringapp with starting version 0.1.0

  ```yaml
  apiVersion: v1
  appVersion: "1.0"
  description: A Helm chart for myspringapp
  name: myspringapp
  version: 0.1.0
  ```

1. values.yaml

  Basic set of values for a Deployment

  ```yaml
  replicaCount: 1

  labels:
    AppName: myspringapp
    AppVersion: "1.0"

  image:
    repository: dockerworkshopdallas/java
    tag: release
    pullPolicy: IfNotPresent
    containerPort: 8181
  ```

  We will run the dockerworkshopdallas/java:release Spring Boot Application available publicly in Dockerhub

1. templates/deployment.yaml

  Templatized Kubernetes Deployment configuration.

  The *{{ }}* are interpolated with the definitions in the values.yaml and Chart.yaml

  **.Chart** refers to anything defined in the Chart.yaml and **.Values** refers to anything defined in the values.yaml

  Using this templating format, a single chart can be applied to any environment simply by providing a different set of values in the values.yaml or a different values file.

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
  ```

1. .helmignore

  This file defines the files or directories that should be ignored by Helm when packaging up the chart using **helm package**

  ```yaml
  # Patterns to ignore when building packages.
  # This supports shell glob matching, relative path matching, and
  # negation (prefixed with !). Only one pattern per line.
  .DS_Store
  # Common VCS dirs
  .git/
  .gitignore
  .bzr/
  .bzrignore
  .hg/
  .hgignore
  .svn/
  # Common backup files
  *.swp
  *.bak
  *.tmp
  *~
  # Various IDEs
  .project
  .idea/
  *.tmproj
  .vscode/
  ```

## Package and Install

Package the chart using **helm package**
`helm package myspringapp`{{execute}}

Check that your chart was packaged correctly
`ls -l`{{execute}}
You should see a file called **myspringapp-0.1.0.tgz**

---

Now you can install your chart
`helm install myspringapp myspringapp-0.1.0.tgz`{{execute}}

---

Verify your chart installed
`helm list`{{execute}}

## Interact with the deployed chart

Using **kubectl**, get the running pod name
`export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/instance=myspringapp" -o jsonpath="{.items[0].metadata.name}")`{{execute}}

Using **kubectl**, forward the pod's traffic on port 80 to your machine's port 8080
`kubectl --namespace default port-forward $POD_NAME 8181:8181 &`{{execute}}
*You may need to press 'Enter' after this command to get back to the prompt*

Using **curl**, call the service on port 8080 (the forwarded port)
`curl http://127.0.0.1:8181/demo`{{execute}}

## Clean up

Stop the port forward process
`kill %1`{{execute}}

## Congrats!

Congrats, you have created and installed your first chart
Move on to the next step to learn how to add a Service to your chart and upgrade the installation

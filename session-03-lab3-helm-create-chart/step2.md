# Add a Service

1. Copy the files from `/usr/local/bin` for **myspringapp2** into **./myspringapp** to add a Service

  `cp -R /usr/local/bin/myspringapp2/* myspringapp/`

## Let't take a look around and see what has changed

1. Chart.yaml

  The version has been changed to 0.2.0

  ```yaml
  apiVersion: v1
  appVersion: "1.0"
  description: A Helm chart for myspringapp
  name: myspringapp
  version: 0.2.0
  ```

1. values.yaml

  A few more values have been added to support the Service

  ```yaml
  spec:
    type: ClusterIP
    port: 8000
    targetPort: 8181
  ```

1. templates/service.yaml

  Templatized Kubernetes Service configuration.

  The *{{ }}* are interpolated with the definitions in the values.yaml and Chart.yaml

  **.Chart** refers to anything defined in the Chart.yaml and **.Values** refers to anything defined in the values.yaml

  Using this templating format, a single chart can be applied to any environment simply by providing a different set of values in the values.yaml or a different values file.

  ```yaml
  kind: Service
  apiVersion: v1
  metadata:
    name: {{quote .Values.labels.AppName }}
    labels:
      service: {{quote .Values.labels.AppName }}
      app.kubernetes.io/instance: {{ .Release.Name }}
      app.kubernetes.io/managed-by: {{ .Release.Service }}
      AppName: {{quote .Values.labels.AppName }}
      AppVersion: {{quote .Values.labels.AppVersion }}
  spec:
    selector:
      AppName: {{quote .Values.labels.AppName }}
    ports:
      - port: {{ .Values.spec.port }}
        targetPort: {{ .Values.spec.targetPort }}
        protocol: TCP
        name: http
  ```

## Package and Install

Package the chart using **helm package**
`helm package myspringapp`{{execute}}

Check that your chart was packaged correctly
`ls -l`{{execute}}
You should see a file called **myspringapp-0.2.0.tgz**

---

Now you can upgrade your chart
`helm upgrade myspringapp myspringapp-0.2.0.tgz`{{execute}}

---

Verify your chart installed
`helm list`{{execute}}

---

And check the new Service component has been deployed
`helm status myspringapp`{{execute}}

## Congrats!

Congrats, you have added a new component to your chart and upgraded it
Move on to the next step to improve your chart by defining resource requests and limitations and adding liveness and readiness probes to your deployment

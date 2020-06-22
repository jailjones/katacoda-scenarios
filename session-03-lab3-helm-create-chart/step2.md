# Upgrade mychart

Now that you have created your own chart called **mychart** from a template, you can modify it to fit your needs

For example, you may want the service to run on a different port

## Modify mychart

Currently, the service is configured to run on port 80, but in the following steps, we will change the service to listen on port 8080

1. In `mychart/templates`, inspect the `deployment.yaml` to see that the container currently runs on port 80

  `cd mychart/templates`

  `cat deployment.yaml`

  Look for the following lines
  ```yaml
  containers:
    - name: {{ .Chart.Name }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 12 }}
      image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      ports:
        - name: http
          containerPort: 80
          protocol: TCP
  ```

  You will modify **containerPort: 80** to **containerPort: 8080**

1. Use the following commands to navigate to `/usr/local/bin/` and inspect and copy the `deployment.yaml` to overwrite the existing file

  `cd /usr/local/bin/`{{execute}}

  `cat deployment.yaml`
  Here you should see that the container port has been changed to 8080
  ```yaml
  containers:
    - name: {{ .Chart.Name }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 12 }}
      image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      ports:
        - name: http
          containerPort: 8080
          protocol: TCP
  ```

# Congrats!

Congrats, you have created and installed your first chart
Move on to the next step to learn how to modify your chart and upgrade the installation

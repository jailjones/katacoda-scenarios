## Lets setup your kubernetes environment

1. Create the monitor-system namespace

    `kubectl create namespace monitor-system`{{execute}}

    Terminal Output
    ```bash
    namespace/monitor-system created
    ```

2. Next we need to add the `stable` repo of helm charts

    `helm repo add stable https://kubernetes-charts.storage.googleapis.com/`{{execute}}

    Terminal Output
    ```bash
    "stable" has been added to your repositories
    ```

3. Update your helm repo to pull down stable charts

    `helm repo update`{{execute}}

    Terminal Output
    ```bash
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "stable" chart repository
    Update Complete. ⎈ Happy Helming!⎈
    ```

4. Install stable helm chart of prometheus operator:

    `helm install prom-op stable/prometheus-operator -n monitor-system`{{execute}}

    >**Note**: This may take up to a minute.

5. Run following commands to verify helm chart successfully installed

    `helm ls -n monitor-system`{{execute}}

6. Check the status of the prometheus-operator pods, they should all be "running"

    `kubectl get pods -n monitor-system`{{execute}}

## FAQ:

- Q1: Why do we need to add a repo for helm?
    - A: By default, helm 3 does not have any repos to integrate with. You are required to explicitly add any repos for Helm3 to utilize.

- Q2: Why install the helm chart `prometheus-operator`?
    - A: Prometheus-operator has a pre-built packaged suite to integrate prometheus, grafana, and alerting in a single install. This approach simplifies the installation and the configuration of your monitoring solution.


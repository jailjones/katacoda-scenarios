## Install Kibana

1. Install `kibana` helm chart from the elastic repo you added in step 2

    `helm install kibana elastic/kibana --set service.type=LoadBalancer --namespace log-system`{{execute}}

    >**Note**: This may take up to 5 minutes.

2. Run following commands to verify helm chart successfully installed

    `helm ls -n log-system`{{execute}}

3. Verify if the pods are in `running` state before moving forward

    `kubectl get pods -n log-system`{{execute}}

## FAQ:

- Q1: What is the purpose of Kibana?
    - A: Kibana allows you to visualize your data or logs in your environment. All data types can be organized and indexed to purposeful and relevant visual dashboards to gain insights into your environment.

    - Kibana enables exploration of your data with stunning visualizations in the UI, from waffle charts and heatmaps to time series analysis and beyond. Customers can utilize preconfigured dashboards for your diverse data sources, create live presentations to highlight KPIs, and manage your deployment in a single UI.
## Install Filebeat

## Install Kibana

1. Install `filebeat` helm chart from the elastic repo you added in step 2

    `helm install filebeat elastic/filebeat --namespace log-system`{{execute}}

    >**Note**: This may take up to 5 minutes.

2. Run following commands to verify helm chart successfully installed

    `helm ls -n log-system`{{execute}}

3. Verify if the pods are in `running` state before moving forward

    `kubectl get pods -n log-system`{{execute}}

## FAQ:

- Q1: What is the purpose of Filebeat?
    - A: Filebeat is part of elastic's `Beats` suite of lightweight tools to ship data and stats of your environment. Filebeat is mainly used to send `log` data to your ELK stack.

- Q2: Are there other tools in the `Beats` tool suite that can be used to grab other data and analytics?
    - A: Yes, below are all the different tools you can install. (These definitions are from elastic's website)

    - MetricBeat - Lightweight shipper for metric data
    - PacketBeat - Lightweight shipper for network data
    - WinLogBeat - Lightweight shipper for Windows event logs
    - AuditBeat  - Lightweight shipper for audit data
    - HeartBeat  - Ligthweight shipper for uptime monitoring
    - FunctionBeat - serverless shipper for cloud data

- Q3: Where does LogStash fit into all of this?
    - A: We are not installing logstash since we only have Filebeat running. Logstash is meant to aggregate multiple different types of sources or systems to stream into your ELK stack

    **About Logstash From Elastic.co**

    Data is often scattered or siloed across many systems in many formats. Logstash supports a variety of inputs that pull in events from a multitude of common sources, all at the same time. Easily ingest from your logs, metrics, web applications, data stores, and various AWS services, all in continuous, streaming fashion.


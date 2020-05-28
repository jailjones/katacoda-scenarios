## Review Kibana Dashboard UI

1. Now run the following and copy the random remote port assigned to Kibana

    `kubectl get service -n monitor-system`{{execute}}

    Review the Kibana service information and take note of the `Port Numbers`

2. Log into Kibana

    - Make sure to copy the 30000+ node port value in the `kibana-kibana 5601:30XXX`

    - Now select the `plus (+)` on the top of the terminal and choose `select host 1 on port` and insert your `30XXX` number

    - Connect  

3. In Kibana, go to the Management → Kibana → Index Patterns page

    - Select `Create Index Patter`
    - Enter `filebeat-*` and select the `@timestamp` field
    - Index should now be created

4. Review your new index dashboard

    - Go to `Discover` in the Kibana home page
    - Now you can review all different logs from containers and pods

5. Exploring the filters and other tasks

    - Try filtering on namespace
        - kubernetes.namespace:kube-system
        - kubernetes.labels.app: `<insert label>`
        - kubernetes.pod.name: `<insert value>`
    - Can you find `stderr` for the prometheus pods?
    - Try creating a new index but utilize a different `field` that is not `@timestamp`
    
6. Create custom field columns for your dashboard

    - I want the following columns in order from left to right
        - timestamp | kubernetes.node.name | kubernetes.pod.name | kubernetes.container.name | message
    - Must be filtered by `kubernetes.pod.name` where the value is `etcd.efk.stack`

7. After creating your custom dashboard, save it in Kibana
    - Save as - `etc-efk-stack-dashboard`

8. Now build another custom dashboard but add the following fields (columns) in addition to the values from Step 6
    - kubernetes.namespace | kubernetes.container.image
    - Also filter this dashboard `kubernetes.pod.name: elasticsearch-master-0`
    - Save dashboard

9. Now click on `Open` in the top of the dashboard and notice your `2` custom dashboards you can review
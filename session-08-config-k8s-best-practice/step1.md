# LimitRange in Namespaces

## Let setup our cluster for using `LimitRange`

1. Create the namespace

    `kubectl create namespace constraints-cpu-example`{{execute}}

2. Apply the limitrange yaml file

    `kubectl apply -f ./cpu-constraints.yaml --namespace=constraints-cpu-example`{{execute}}

3. Now view the LimitRange in the namespace

    `kubectl get limitrange cpu-min-max-demo-lr --output=yaml --namespace=constraints-cpu-example`{{execute}}

Now whenever a Container is created in the constraints-cpu-example namespace, Kubernetes performs these steps:

- If the Container does not specify its own CPU request and limit, assign the default CPU request and limit to the Container.
- Verify that the Container specifies a CPU request that is greater than or equal to 200 millicpu.
- Verify that the Container specifies a CPU limit that is less than or equal to 800 millicpu.

We will now apply a configuration file for a Pod that has one Container. The Container manifest specifies a CPU request of 500 millicpu and a CPU limit of 800 millicpu. These satisfy the minimum and maximum CPU constraints imposed by the LimitRange.

4. Create the pod

`kubectl apply -f ./cpu-constraints-pod.yaml --namespace=constraints-cpu-example`{{execute}}

5. Verify everything is running as expected

`kubectl get pod constraints-cpu-demo --namespace=constraints-cpu-example`{{execute}}

More detailed information

`kubectl get pod constraints-cpu-demo --output=yaml --namespace=constraints-cpu-example`{{execute}}

The output shows that the Container has a CPU request of 500 millicpu and CPU limit of 800 millicpu. These satisfy the constraints imposed by the LimitRange.

6. Delete the pod

`kubectl delete pod constraints-cpu-demo --namespace=constraints-cpu-example`{{execute}}

## Next we are going to create a pod that exceeds the LimitRange's CPU `Limit` requirements and see what happens

7. Let review the `cpu-constraints-pod-2.yaml` file

`cat ./cpu-constraints-pod-2.yaml`{{execute}}

Notice how we are requesting `1.5` cpu for our container which is above our LimitRange

8. Now let us apply the new pod

`kubectl apply -f ./cpu-constraints-pod-2.yaml --namespace=constraints-cpu-example`{{execute}}

The output shows that the Pod does not get created, because the Container specifies a CPU limit that is too large. Since the limit of the CPU for Pod-2 is `1.5` it exceeds the maximum of LimitRange CPU Limit of `800mi` (millicpu). **1.5 > .8**

## Next we are going to create a pod that does not meet the LimitRange CPU `Request` requirements and see what happens

9. Review the `cpu-constraints-pod-3.yaml` file

`cat ./cpu-constraints-pod-3.yaml`{{execute}}

10. Create Pod 3

`kubectl apply -f ./cpu-constraints-pod-3.yaml --namespace=constraints-cpu-example`{{execute}}

The output shows that the Pod does not get created, because the Container specifies a CPU request that is too small

## Lastly, we are going to see what happens when you build a Pod with no cpu limits or requests explicitly stated in the yaml file

11. Let us review Pod 4's yaml file

`cat ./cpu-constraints-pod-4.yaml`{{execute}}

12. Create Pod 4

`kubectl apply -f ./cpu-constraints-pod-4.yaml --namespace=constraints-cpu-example`{{execute}}

13. View the detail information about Pod 4

`kubectl get pod constraints-cpu-demo-4 --namespace=constraints-cpu-example --output=yaml`{{execute}}

The output shows that the Pod’s Container has a CPU request of 800 millicpu and a CPU limit of 800 millicpu. How did the Container get those values?

Because your Container did not specify its own CPU request and limit, it was given the default CPU request and limit from the LimitRange.

14. Now cleanup your pod by deleting it

`kubectl delete pod constraints-cpu-demo-4 --namespace=constraints-cpu-example`{{execute}}
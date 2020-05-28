# What are Deployments?
Kuberentes provides a built-in rollback mechanism. There are several strategies available to us when we're deploying applications into production. By default, Kubernetes uses the rolling update strategy to update the running version of your application.

What is a rolling update strategy? The rolling update cycles previous Pods out and brings in newer Pods incrementally.

Before we get our hands dirty, let's understand what actually happens when a **Deployment** is updated.

---

## You have a Service and a Deployment with three replicas on version `1.0.0`. You change the `image` in your Deployment to version `2.0.0`, here's what happens next
![Rolling Update 2](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-2.png)

---

## In a rolling update, Kubernetes create a Pod with a new version of the image
![Rolling Update 3](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-3.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 4](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-4.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 5](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-5.png)

---

## The previous Pod is removed and Kubernetes is ready to start again
![Rolling Update 6](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-6.png)

---

## The previous Pod is removed and Kubernetes is ready to start again
![Rolling Update 7](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-7.png)

---

## Another Pod with the current image is created
![Rolling Update 8](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-8.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 9](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-9.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 10](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-10.png)

---

## The previous Pod is removed
![Rolling Update 11](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-11.png)

---

## The previous Pod is removed
![Rolling Update 12](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-12.png)

---

## And for the last time, a Pod with the current image is created
![Rolling Update 13](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-13.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 14](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-14.png)

---

## Kubernetes waits for readiness and liveness probe. When both are healthy, the Pod is running and can receive traffic
![Rolling Update 15](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-15.png)

---

## The previous Pod is removed
![Rolling Update 16](/k8s-workshop/scenarios/session-02-core-concepts/assets/rolling-16.png)

---

## The migration from the previous to current version is complete

Zero-downtime deployment is convenient when you wish not to interrupt your live traffic.

You can deploy as many times as you want and your users won't be able to notice the difference.

However, even if you use techniques such as Rolling updates, there's still risk that your application doesn't work the way you expect it at the end of the deployment. So you should have a plan to roll back the change.

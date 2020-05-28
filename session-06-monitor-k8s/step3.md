## Open Kubernetes Dashboard

    By design, minikube has a built in dashboard to launch that helps you review all resources in your cluster

1. Log into the minikube cluster

`minikube dashboard`{{execute}}

2. Review the dashboard UI

    - See how many namespaces there are
    - Review the different cluster roles
    - Review the k8 verbs it has access to
    - Change the namespace to monitor and review all its resources

3. View the Custom Resource Definitions (CRDs) in your monitor namespace

    - This can help you keep track which CRDs are installed in your namespaces

## FAQ:

- Q1: Do all kubernetes clusters come pre-installed with a dashboard?
    - A: No, you have to enable or install `kuberenetes dashboard` utilizing helm or running a `kubectl apply -f install.yaml` from kubernetes dashboard website. Minikube by default has it prebuilt for you to login to.
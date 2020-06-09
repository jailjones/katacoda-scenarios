## Helm CLI

Let's get familiar with Helm CLI by checking out a few different commands

To see a full list of available commands, run **help**
`helm help`{{execute}}

All `helm` commands execute against the cluster you define in your context. For the purposes of this workshop, we will be executing all commands against the local minikube cluster.

---

Common commands include
* helm search:    search for charts
* helm fetch:     download a chart to your local directory to view
* helm install:   upload the chart to Kubernetes
* helm list:      list releases of charts

### Run MySQL in Kubernetes cluster

We will search the official Helm repository for a MySQL chart and install the chart into the locally running Kubernetes cluster

Lets find a MySQL chart.
`helm search repo stable`{{execute}}
This command returns a comprehensive list of all of the charts available in this repository.

Lets filter the list to only include the type of chart we are interested in
`helm search repo stable/mysql`{{execute}}

---

Let's install the chart into our cluster. With this command we will install the **stable/mysql** chart with a release name of **mysql**
`helm install stable/mysql --name mysql`{{execute}}

---

Verify the release is installed in the cluster
`helm list`{{execute}}

---

Check the status of the release
`helm status mysql`{{execute}}

---

## TODO kubectl commands to list deployment, pods, etc

---

Let's interact with our first Helm deployment in the Kubernetes cluster.
We will log into the MySQL deployment in the cluster.
### TODO

---

Uninstall the release
`helm delete mysql`{{execute}}

---

Verify the release is uninstalled
`helm list`{{execute}}

---

## TODO kubectl commands to list deployment, pods, etc

### That's it! Good job on completing this lab and we hope it has introduced some fundementals of Helm CLI

### Optional Step

Before we install the chart into our cluster, we may want to take a look at it to verify it is what we want or to modify it to fit your needs.
This step is not required to install a chart and can be done optionally
Fetch the chart using
`helm fetch stable/mysql`{{execute}}

Additionally, it is more secure to download the chart and keep a local copy of it with your source code or upload it to a private repository so you can better control version upgrades and dependencies when installing helm charts sourced from public repos.
Instead of installing the chart directly from a public repository, install it from a private repository that you control or from a local directory.
`helm install mysql <path_to_local_directory>`

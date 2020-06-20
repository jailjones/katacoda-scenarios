To enable long-term data storage, that lasts longer than a Pod's lifecycle, kubernetes provides PersistentVolumes and PersistentVolumeClaims. Containers access these like any other Volume, but kubernetes keeps track of changes and manages persisting them over time.

The PersistentVolumes are set up by the cluster administrators, sort of like Nodes. In the same way that a Node is an abstraction that can respresent any variety of hardware or cloud servers, a PersistentVolume is an abstraction over any type of persistent storage. The official docs give the examples of a Google Compute Engine persistent disk, an NFS share, or an Amazon Elastic Block Store volume.

> It's possible to configure multiple types of PersistentVolumes in a cluster, and then configure each individual Pod to use a particular type of PV based on performance, cost, or features of the underlying storage system.

The app developer creates Pods to use the cluster's Nodes, and creates PersistentVolumeClaims to use the cluster's PersistentVolumes.

---

## Bonus Lab: PersistentVolume

Bored? Check out this lab by the official kubernetes team: https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

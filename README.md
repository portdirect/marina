# Marina

Essentially HarborV2, Marina is a Federated OpenStack/Kubernetes distro that uses Helm for depolyment, and Ceph for stateful storage.


### Quckstart

Assuming you have a Kubeadm managed Kubernetes 1.5 cluster and Helm 2.1 setup, you can get going straight away! [1]

From the root of this repo run:

```
helm serve &
helm repo add marina http://127.0.0.1:8879/charts

make build-ceph
make build-dkr-ceph
make install

helm repo update

#Generate secrets and config for ceph deployment
#                <ns> <storagecidr> <public cidr>
helm ceph secret ceph 10.192.0.0/10 10.192.0.0/10

#Label the nodes that will take part in the ceph cluster
# 'all' labels all nodes in the cluster bar the k8s controller node(s)
helm ceph labelnode all

#Deploy ceph to the namespace setup above
helm install marina/ceph --namespace ceph --dry-run --debug

#Setup client credentials for a namespace
helm ceph activate default

```

#### Notes
[1] The cake is a lie, you acutually need to have the nodes setup to access the cluster network, and `/etc/resolv.conf` setup similar to the following:
```
search default.svc.cluster.local svc.cluster.local cluster.local
nameserver 10.96.0.10 # K8s DNS IP
nameserver 192.168.121.1 # External DNS IP
options ndots:5
# These options enable hostname resolution to work when the kube-dns service
# is unavalible without an absolutely atrocious performance impact.
options timeout:1
options attempts:1
```

#/bin/bash

function kube_base64 () {
  cat /secrets/$1 | base64 | tr -d '\n'
}
cat >> /dev/stdout <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: "ceph-conf-combined"
type: Opaque
data:
  ceph.conf: |
    $( kube_base64 ceph.conf )
  ceph.client.admin.keyring: |
    $( kube_base64 ceph.client.admin.keyring )
  ceph.mon.keyring: |
    $( kube_base64 ceph.mon.keyring )
---
apiVersion: v1
kind: Secret
metadata:
  name: "ceph-bootstrap-rgw-keyring"
type: Opaque
data:
  ceph.keyring: |
    $( kube_base64 ceph.rgw.keyring )
---
apiVersion: v1
kind: Secret
metadata:
  name: "ceph-bootstrap-mds-keyring"
type: Opaque
data:
  ceph.keyring: |
    $( kube_base64 ceph.mds.keyring )
---
apiVersion: v1
kind: Secret
metadata:
  name: "ceph-bootstrap-osd-keyring"
type: Opaque
data:
  ceph.keyring: |
    $( kube_base64 ceph.osd.keyring )
---
apiVersion: v1
kind: Secret
metadata:
  name: "ceph-client-key"
type: Opaque
data:
  ceph-client-key: |
    $( kube_base64 ceph-client-key )
---
apiVersion: v1
kind: Secret
metadata:
  name: "pvc-ceph-conf-combined-storageclass"
type: kubernetes.io/rbd
data:
  key: |
    $( kube_base64 ceph-client-key )
EOF

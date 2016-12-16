#/bin/bash
cd /opt/ceph

./generate_secrets.sh all `./generate_secrets.sh fsid`

./create_manifests.sh

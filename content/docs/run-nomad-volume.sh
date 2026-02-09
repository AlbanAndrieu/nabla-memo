#!/bin/bash
set -xv

# openstack volume list
# openstack volume type list
# openstack volume show cinder-gra-influxdb-dev
# openstack volume show cinder-gra-influxdb-dev -c 'availability_zone'
# nomad plugin status
# nomad plugin status -verbose cinder-csi_plugin
# nomad volume status --namespace=*
# nomad volume status --namespace=* cinder-gra-influxdb-dev

# Warning : Warning using terraform, upon tfstate change terraform will force block storage replacement.
# We do not want this behavior as we will lose our data.
# See https://www.notion.so/jusmundi/Dynamic-storage-cfce093d8b9743efbc13bb4d11bbfe52?pvs=4#06c7ead7d87f4c11a547ff876fbe11e9
# nomad volume status --namespace=*
# nomad volume delete --namespace=telemetry cinder-gra-victoriametrics-dev

# terraform state list
# terraform state show nomad_csi_volume.cinder-gra-victoriametrics[0]
# terraform state rm nomad_csi_volume.cinder-gra-victoriametrics[0]

exit 0

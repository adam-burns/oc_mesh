#!/bin/bash

PF_GRAFANA=$(oc get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}')
PF_GRAFANA_CMD="nohup oc port-forward ${PF_GRAFANA} 3000:3000 &"
echo "executing ${PF_GRAFANA_CMD}"
nohup oc port-forward $(oc get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &

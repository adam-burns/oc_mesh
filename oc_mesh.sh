#!/bin/bash

# download istio & add istioctl to path
. init.sh

# bring openshift cluster up
oc cluster up 
#oc cluster up --use-existing-config
#oc cluster up --routing-suffix="192.168.178.83.nip.io"

# login as system:admin
oc login -u system:admin

# create new project
oc new-project istio-system
oc project istio-system

# add openshift policies for istio
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account
oc adm policy add-scc-to-user privileged -z istio-ingress-service-account
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account
oc adm policy add-scc-to-user privileged -z istio-egress-service-account
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account
oc adm policy add-scc-to-user privileged -z istio-pilot-service-account
oc adm policy add-scc-to-user anyuid -z default
oc adm policy add-scc-to-user privileged -z default
oc adm policy add-cluster-role-to-user cluster-admin -z default

oc apply -f ${ISTIO}/install/kubernetes/istio.yaml

oc create -f ${ISTIO}/install/kubernetes/addons/prometheus.yaml
oc create -f ${ISTIO}/install/kubernetes/addons/grafana.yaml
oc create -f ${ISTIO}/install/kubernetes/addons/servicegraph.yaml
oc create -f ${ISTIO}/install/kubernetes/addons/zipkin.yaml
oc expose svc grafana
oc expose svc servicegraph
oc expose svc zipkin

## seems to be required for istio grafana instance ... see https://istio.io/docs/tasks/telemetry/using-istio-dashboard.html
#sleep 20
#nohup oc port-forward $(oc get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &

export SERVICEGRAPH=$(oc get route servicegraph -o jsonpath='{.spec.host}{"\n"}')/dotviz
export GRAFANA=$(oc get route grafana -o jsonpath='{.spec.host}{"\n"}'):3000/dashboard/db/istio-dashboard
export ZIPKIN=$(oc get route zipkin -o jsonpath='{.spec.host}{"\n"}')

echo "Openshift Cluster raised & Istio booted"

echo "SERVICEGRAPH=$SERVICEGRAPH"
echo "GRAFANA=$GRAFANA"
echo "ZIPKIN=$ZIPKIN"

echo "Status:"
oc get -o wide pods


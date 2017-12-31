#!/bin/bash

. ./init.sh

# oc login
oc login -u system:admin

oc apply -f <(istioctl kube-inject -f ${ISTIO}/samples/bookinfo/kube/bookinfo.yaml)
oc expose svc productpage

export PRODUCTPAGE=$(oc get route productpage -o jsonpath='{.spec.host}{"\n"}')

echo "Bookapp URL= $PRODUCTPAGE"


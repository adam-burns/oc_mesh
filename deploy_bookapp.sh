#!/bin/bash

# oc login
oc login -u system:admin

ISTIO=`ls | grep istio`
export PATH="${PATH}:${ISTIO}/bin"

echo "PATH:= $PATH"

read line

oc apply -f <(istioctl kube-inject -f ${ISTIO}/samples/bookinfo/kube/bookinfo.yaml)
oc expose svc productpage

export PRODUCTPAGE=$(oc get route productpage -o jsonpath='{.spec.host}{"\n"}')

oc get -o wide pods

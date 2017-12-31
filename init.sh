#!/bin/bash

ISTIO=`ls -d */ | grep istio`

echo "ISTIO=$ISTIO"

if [ -z "${ISTIO}" ]; then
  curl -L https://git.io/getLatestIstio | sh - # don't do this at home, kids ...
fi

export ISTIO=`ls -d */ | grep istio`
export PATH="$PATH:`pwd`/${ISTIO}bin"

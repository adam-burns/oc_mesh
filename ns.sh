export SERVICEGRAPH=$(oc get route servicegraph -o jsonpath='{.spec.host}{"\n"}')/dotviz
export GRAFANA=$(oc get route grafana -o jsonpath='{.spec.host}{"\n"}'):3000/dashboard/db/istio-dashboard
export ZIPKIN=$(oc get route zipkin -o jsonpath='{.spec.host}{"\n"}')

export PRODUCTPAGE=$(oc get route productpage -o jsonpath='{.spec.host}{"\n"}')

echo "SERVICEGRAPH= $SERVICEGRAPH"
echo "GRAFANA= $GRAFANA"
echo "ZIPKIN= $ZIPKIN"
echo "Bookapp URL= $PRODUCTPAGE"

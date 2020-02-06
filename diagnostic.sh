#!/bin/bash
#
# a helper script to fetch Kubernetes settings and Deep Security Smart Check logs.
#
# added by me on 2-7-2020
# from https://raw.githubusercontent.com/deep-security/smartcheck-helm/master/collect-logs.sh

RELEASE=deepsecurity-smartcheck
KUBECTL=kubectl
HELM=helm

#####
# check prerequisites
#####
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

if ! command_exists $KUBECTL; then
  echo "No kubectl command found, exiting..."
  exit 1
fi

if ! command_exists $HELM; then
  echo "No helm command found, exiting..."
  exit 1
fi

# prepare the output folder
RESULTS_DIR="${RESULTS_DIR:-/tmp/smartcheck}"
MASTER_DIR="${RESULTS_DIR}/master"
mkdir -p "$MASTER_DIR/apps"
echo "Results folder: $RESULTS_DIR"

#####
# setting logs
#####
COMMANDS=( "version:$KUBECTL version"
           "components:$KUBECTL get componentstatuses"
           "events:$KUBECTL get events --all-namespaces"
           "storageclass:$KUBECTL describe storageclass"
           "helm:$HELM list"
           "helm-status:$HELM status $RELEASE"
           "nodes:$KUBECTL describe nodes"
           "podlist:$KUBECTL get pods --all-namespaces"
           "smartcheck-get:$KUBECTL get all --all-namespaces -l release=$RELEASE"
           "smartcheck-desc:$KUBECTL describe all --all-namespaces -l release=$RELEASE"
           "smartcheck-desc-netpol:$KUBECTL describe networkpolicy --all-namespaces -l release=$RELEASE"
           "smartcheck-secrets:$KUBECTL get secrets --all-namespaces -l release=$RELEASE"
           "smartcheck-config:$KUBECTL describe configmap --all-namespaces -l release=$RELEASE")

echo "Fetching setting logs..."
for command in "${COMMANDS[@]}"; do
    KEY="${command%%:*}"
    VALUE="${command##*:}"
    echo "Command:" "$VALUE" > "$MASTER_DIR/$KEY.log"
    echo "====================================" >> "$MASTER_DIR/$KEY.log"
    $VALUE >> "$MASTER_DIR/$KEY.log" 2>&1
done

#####
# application logs
#####
NAMESPACE=${NAMESPACE:-default}
NAMESPACE_PARAM="--namespace=$NAMESPACE"

PODS=$($KUBECTL get pods "$NAMESPACE_PARAM" -o=jsonpath='{range .items[*]}{.metadata.name}{";"}{end}' -l release=$RELEASE)
for pod in $(echo "$PODS" | tr ";" "\n"); do
    CONTAINERS=$($KUBECTL get pods "$NAMESPACE_PARAM" "$pod" -o jsonpath='{.spec.initContainers[*].name}')
    for container in $CONTAINERS; do
        echo "Fetching Deep Security Smart Check logs... $pod - $container"
        $KUBECTL logs "$NAMESPACE_PARAM" "$pod" -c "$container" > "$MASTER_DIR/apps/$pod-$container.log"
        # check for any previous containers, this would indicate a crash
        PREV_LOGFILE="$MASTER_DIR/apps/$pod-$container-previous.log"
        if ! $KUBECTL logs "$NAMESPACE_PARAM" "$pod" -c "$container" -p > "$PREV_LOGFILE" 2>/dev/null; then
            rm -f "$PREV_LOGFILE"
        fi
    done

    # list containers in pod
    CONTAINERS=$($KUBECTL get pods "$NAMESPACE_PARAM" "$pod" -o jsonpath='{.spec.containers[*].name}')
    for container in $CONTAINERS; do
        echo "Fetching Deep Security Smart Check logs... $pod - $container"
        $KUBECTL logs "$NAMESPACE_PARAM" "$pod" -c "$container" > "$MASTER_DIR/apps/$pod-$container.log"
        # check for any previous containers, this would indicate a crash
        PREV_LOGFILE="$MASTER_DIR/apps/$pod-$container-previous.log"
        if ! $KUBECTL logs "$NAMESPACE_PARAM" "$pod" -c "$container" -p > "$PREV_LOGFILE" 2>/dev/null; then
            rm -f "$PREV_LOGFILE"
        fi
    done
done

#collect the logs then upload to BitBucket
echo "-----------------------------"
echo "COLLECTING DIAGNOSTIC PACKAGE"
echo "-----------------------------"
export EPOCH_TIME=$(date '+%s')
zip -rq diagnostic$EPOCH_TIME.zip /tmp/smartcheck/
mv diagnostic$EPOCH_TIME.zip /tmp/
echo "diagnostic package located at /tmp/diagnostice$EPOCH_TIME.zip"

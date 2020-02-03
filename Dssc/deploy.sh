#!/bin/bash

kubectl delete networkpolicies proxy
sleep 2s

helm install --set service.type=NodePort  --set persistence.enabled=false --set activationCode=$ACTIVATION_CODE --set auth.secretSeed=$DSSC_SECRET_SEED deepsecurity-smartcheck ./temp/smartcheck-helm-master/.

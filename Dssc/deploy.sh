#!/bin/bash
helm delete --debug deepsecurity-smartcheck
sleep 5s
helm install --debug --set service.type=NodePort  --set persistence.enabled=false --set activationCode="$ACTIVATION_CODE" --set auth.secretSeed="$DSSC_SECRET_SEED" deepsecurity-smartcheck ./temp/smartcheck-helm-master/.

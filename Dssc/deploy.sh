#!/bin/bash

helm install --debug --replace --set service.type=NodePort  --set persistence.enabled=false --set activationCode=$ACTIVATION_CODE --set auth.secretSeed=$DSSC_SECRET_SEED deepsecurity-smartcheck ./temp/smartcheck-helm-master/.

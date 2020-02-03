#!/bin/bash

helm install --set persistence.enabled=false --set activationCode=$ACTIVATION_CODE --set auth.secretSeed=$DSSC_SECRET_SEED --set service.type=NodePort deepsecurity-smartcheck ./temp/smartcheck-helm-master/

#!/bin/bash
helm install --debug --wait --timeout 10m --set service.type=NodePort  --set persistence.enabled=false --set activationCode="$ACTIVATION_CODE" --set auth.secretSeed="$DSSC_SECRET_SEED" deepsecurity-smartcheck https://github.com/deep-security/smartcheck-helm/archive/master.tar.gz

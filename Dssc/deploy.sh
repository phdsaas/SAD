#!/bin/bash

helm install --debug --replace --set service.type=NodePort  --set persistence.enabled=false --set activationCode=AP-R9RM-92WHD-B2UR5-BV2YB-HZYM8-HYYVA --set auth.secretSeed=N0virus1 deepsecurity-smartcheck ./temp/smartcheck-helm-master/.

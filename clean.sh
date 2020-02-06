#!/bin/bash

helm --debug delete deepsecurity-smartcheck
kubectl delete services static-proxy
rm -rf /tmp/smartcheck
sleep 10s

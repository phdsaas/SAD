#!/bin/bash

helm --debug delete deepsecurity-smartcheck
kubectl delete services static-proxy
rm -rf /tmp/smartcheck
rm -f /tmp/diagnostic*.zip
sleep 10s

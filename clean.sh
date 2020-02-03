#!/bin/bash

helm --debug delete deepsecurity-smartcheck
kubectl delete services static-proxy
sleep 10s

#!/bin/bash

kubectl apply --wait -f static-service.yaml
sleep 5s
kubectl get services

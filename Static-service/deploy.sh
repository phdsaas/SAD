#!/bin/bash

kubectl apply --wait -f static-service.yaml
kubectl get services

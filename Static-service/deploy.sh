#!/bin/bash

kubectl apply --wait -f ./Static-service/static-service.yaml
kubectl get services

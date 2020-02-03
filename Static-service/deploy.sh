#!/bin/bash

kubectl apply -f ./Static-service/static-service.yaml
sleep 5s
kubectl get services

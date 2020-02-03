#!/bin/bash

sudo kubectl apply --wait -f ./Static-service/static-service.yaml
sudo kubectl get services

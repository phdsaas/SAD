#!/bin/bash

#Set service http port to 30080
sed -ie '/^      targetPort/a \ \ \ \ \ \ nodePort: 30080' ./temp/smartcheck-helm-master/templates/proxy.yaml >> /dev/null

#Set service https port to 30443
sed -ie '19 s/30080/30443/' ./temp/smartcheck-helm-master/templates/proxy.yaml >> /dev/null

#Delete nodePort at line 30
sed -ie '30d' ./temp/smartcheck-helm-master/templates/proxy.yaml >> /dev/null

head -32 ./temp/smartcheck-helm-master/templates/proxy.yaml

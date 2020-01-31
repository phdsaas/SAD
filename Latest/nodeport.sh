#!/bin/bash

#Set service https port to 30443
sed -ie '/^      targetPort/a \ \ \ \ \ \ nodePort: 30080' smartcheck-helm-master/templates/proxy.yaml

#Set service http port to 30080
sed '19 s/30080/30443/' smartcheck-helm-master/templates/proxy.yaml

#Delete nodePort at line 30
sed '30,$d' smartcheck-helm-master/templates/proxy.yaml

cat smartcheck-helm-master/templates/proxy.yaml
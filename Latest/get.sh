#!/bin/bash

rm -rf
mkdir temp
cd temp

#Download Latest Chart
curl -LO  https://github.com/deep-security/smartcheck-helm/archive/master.tar.gz
tar -xvzf master.tar.gz

echo "Smart Check version"
cat smartcheck-helm-master/Chart.yaml | grep "version"
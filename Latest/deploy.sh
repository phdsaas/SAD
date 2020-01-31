#!/bin/bash

rm -rf
mkdir temp
cd temp

#Download Latest Chart
curl -LO  https://github.com/deep-security/smartcheck-helm/archive/master.tar.gz
tar -xvzf master.tar.gz
cd smartcheck-helm-master

echo "Smart Check version"
cat Chart.yaml | grep "version"
#!/bin/bash

#Generate Token
export DSSC_TOKEN=$(curl -k https://smartcheck.jayveev.tmi:30443/api/sessions --header "Content-Type: application/json" --request POST --data '{
"user": {
"userID": "'"$DSSC_USER"'",
"password": "'"$DSSC_PASS"'"
}
}' | jq -r '.token')

#Change admin password
curl -k https://smartcheck.jayveev.tmi:30443/api/users/administrator/password --header "Content-Type: application/json" --header "Authorization: Bearer $DSSC_TOKEN" --request POST --data '{
"oldPassword": "'"$DSSC_PASS"'",
"newPassword": "'"$DSSC_PASS_NEW"'"
}'

#Add new registry
curl -k https://smartcheck.jayveev.tmi:30443/api/registries --header "Content-Type: application/json" --header "Authorization: Bearer $DSSC_TOKEN" --request POST --data '{
"name": "PHDSaaS ECR",
"description": "This registry is manages by PH DSaaS Support Team",
"host": "smartcheck.jayveev.tmi",
"credentials": {
"username": "'"$DSSC_USER"'",
"password": "'"$DSSC_PASS"'",
"aws": {
"region": "'"$AWS_REGION"'",
"accessKeyID": "'"$AWS_AK"'",
"secretAccessKey": "'"$AWS_SK"'",
"registry": "'"$AWS_ACCOUNT_ID"'"
}
},
"insecureSkipVerify": true,
"schedule": false
}'

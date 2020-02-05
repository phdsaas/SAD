#!/bin/bash

#Create a session
curl -k https://smartcheck.jayveev.tmi:30443/api/sessions --header "Content-Type: application/json" --request POST --data '{
"user": {
"userID": "'"$DSSC_USER"'",
"password": "'"$DSSC_PASS"'"
}
}' >> session.json

#Export variables
export DSSC_TOKEN=$(cat session.json | jq -r '.token')
export DSSC_USER_ID=$(cat session.json | jq -r '.user.id')
rm -rf session.json

#Change admin password
curl -k https://smartcheck.jayveev.tmi:30443/api/users/$DSSC_USER_ID/password --header "Content-Type: application/json" --header "Authorization: Bearer $DSSC_TOKEN" --request POST --data '{
"oldPassword": "'"$DSSC_PASS"'",
"newPassword": "'"$DSSC_PASS_NEW"'"
}'

#Add new registry
curl -k https://smartcheck.jayveev.tmi:30443/api/registries --header "Content-Type: application/json" --header "Authorization: Bearer $DSSC_TOKEN" --request POST --data '{
"name": "PHDSaaS ECR",
"description": "This registry is managed by PH DSaaS Support Team",
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

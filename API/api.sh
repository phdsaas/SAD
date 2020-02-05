curl -k https://smartcheck.jayveev.tmi:30443/api/sessions --header "Content-Type: application/json" --request POST --data '{
"user": {
"userID": "administrator",
"password": "env.DSSC_PASS"
}
}'
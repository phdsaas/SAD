curl -k https://smartcheck.jayveev.tmi:30443/api/sessions --header "Content-Type: application/json" --request POST --data '{
"user": {
"userID": "'"$DSSC_USER"'",
"password": "'"$DSSC_PASS"'"
}
}' >> token.txt

cat token.txt

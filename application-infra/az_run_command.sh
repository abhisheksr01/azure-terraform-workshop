#!/bin/bash
set -e

apt-get update && apt-get install curl jq -y
PUBLIC_IP=$(az network public-ip show -g abhishek_demo_app_rg -n abhishek_demo_public_ip | jq -r '.ipAddress')
echo "1111111111"
echo $PUBLIC_IP
RESPONSE=$(curl -I -s -X GET -H "Header:Value" $PUBLIC_IP:5000/greetings/abhishek)
echo "$RESPONSE"
if [[ "$RESPONSE" == *"HTTP/1.1 200 OK"* ]]; then
  echo "VALIDATION IS SUCCESSFULL"
  exit 0
fi
echo "VALIDATION FAILED"
exit 1

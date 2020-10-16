#!/bin/bash

echo -n "Installing helm ..."
echo ""
sleep 1
curl https://baltocdn.com/helm/signing.asc | apt-key add -
apt-get install apt-transport-https --yes  2&> /dev/null
sleep 1
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install helm
sleep 1
echo -n "Installation completed!!"


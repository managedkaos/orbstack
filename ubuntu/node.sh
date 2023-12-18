#!/bin/bash
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
	| gpg --batch --yes --dearmor -o /etc/apt/keyrings/nodesource.gpg

echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR:-20}.x nodistro main" \
	| tee /etc/apt/sources.list.d/nodesource.list

apt-get update
apt install -y nodejs
npm install --global yarn

for i in node npm npx yarn;
do
	echo "$(which ${i}) $(${i} --version)"
done

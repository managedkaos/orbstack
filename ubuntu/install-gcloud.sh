#!/bin/bash

cd /usr || exit 1

curl -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
tar -xf google-cloud-cli-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh --quiet
rm -vf /usr/google-cloud-cli-linux-x86_64.tar.gz

echo "Add the following lines to ~/.bashrc"
echo
echo "# Update PATH for the Google Cloud SDK."
echo "if [ -f '/tmp/google-cloud-sdk/path.bash.inc' ]; then . '/tmp/google-cloud-sdk/path.bash.inc'; fi"
echo
echo "# Enable shell command completion for gcloud."
echo "if [ -f '/tmp/google-cloud-sdk/completion.bash.inc' ]; then . '/tmp/google-cloud-sdk/completion.bash.inc'; fi"


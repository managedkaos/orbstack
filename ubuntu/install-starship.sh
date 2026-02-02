#!/bin/bash
apt install curl -y
curl -sS https://starship.rs/install.sh | sh -s -- -y
echo "Add the following to the end of ~/.bashrc:"
echo 'eval "$(starship init bash)"'
echo "Configure prompt to remove Systemd container"
echo "mkdir -p ~/.config && touch ~/.config/starship.toml"
echo "then edit ~/.config/starship.toml and add:"
echo "[container]"
echo "disabled = true"

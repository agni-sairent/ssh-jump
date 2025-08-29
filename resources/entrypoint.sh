#!/usr/bin/env bash

echo "[1/3] Generating server host keys..."
mkdir -p "/config/.ssh"

ssh-keygen -t ed25519 -N "" -f /config/.ssh/id_ed25519


touch "/config/.ssh/authorized_keys"

if [ -z "$USER_PUBLIC_KEY" ]; then
  echo "User's public key not provided, what am I supposed to do?"
  echo "Set variable $USER_PUBLIC_KEY to your public key, it will be added to authorized_keys file, so you can login with your private key."
  echo "Exiting..."
  exit 1
fi

echo "$USER_PUBLIC_KEY" > "/config/.ssh/authorized_keys"

/usr/sbin/sshd -f /config/sshd_config

echo "SSH Server configured and started!"
tail -f /dev/null
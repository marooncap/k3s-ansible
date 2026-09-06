#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f /etc/os-release ]]; then
  echo "Cannot detect OS. Exiting."
  exit 1
fi

. /etc/os-release

if ! command -v vagrant >/dev/null 2>&1; then
  read -r -p "vagrant is not installed. Do you want to install it? [y/N]: " answer
  if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi

  if [[ "${ID:-}" != "debian" && "${ID:-}" != "ubuntu" ]]; then
    echo "This script only runs on Debian or Ubuntu. Detected: ${ID:-unknown}"
    exit 1
  fi

  sudo apt-get update
  sudo apt-get install -y wget gpg lsb-release

  if [[ ! -f /usr/share/keyrings/hashicorp-archive-keyring.gpg ]]; then
    wget -O - https://apt.releases.hashicorp.com/gpg |
      sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  fi

  if [[ ! -f /etc/apt/sources.list.d/hashicorp.list ]]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(. /etc/os-release && echo ${UBUNTU_CODENAME:-$(lsb_release -cs)}) main" |
      sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
  fi

  sudo apt-get update
  sudo apt-get install -y vagrant

  echo "Vagrant installation complete."
fi

if uname -r | grep -qi wsl; then
  PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox" VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1" molecule test
else
  molecule test
fi

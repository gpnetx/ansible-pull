#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/gpnetx/ansible-pull.git"
PLAYBOOK="base.yml"
WORKDIR="/var/lib/ansible-pull"

if [[ "${EUID}" -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

echo "==> Updating apt cache..."
$SUDO apt-get update

echo "==> Installing git and ansible..."
$SUDO apt-get install -y git ansible

echo "==> Creating working directory..."
$SUDO mkdir -p "$WORKDIR"
$SUDO chown "$(id -u)":"$(id -g)" "$WORKDIR"

echo "==> Running ansible-pull from $REPO_URL ..."
ansible-pull \
  -U "$REPO_URL" \
  -d "$WORKDIR" \
  -i localhost, \
  -c local \
  "$PLAYBOOK"

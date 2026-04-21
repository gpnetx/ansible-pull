#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/gpnetx/ansible-pull.git"
PLAYBOOK="base.yml"
WORKDIR="/var/lib/ansible-pull"

# Use sudo if not already running as root
if [[ "${EUID}" -ne 0 ]]; then
    SUDO="sudo"
else
    SUDO=""
fi

echo "==> Updating apt package cache..."
$SUDO apt-get update

echo "==> Installing required packages (git + ansible)..."
$SUDO apt-get install -y git ansible

echo "==> Creating ansible-pull working directory..."
$SUDO mkdir -p "$WORKDIR"

echo "==> Running ansible-pull from GitHub..."
$SUDO ansible-pull \
    -U "$REPO_URL" \
    -d "$WORKDIR" \
    -i localhost, \
    -c local \
    -l localhost \
    "$PLAYBOOK"

echo "==> Bootstrap complete."

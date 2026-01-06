#!/usr/bin/env bash
set -euo pipefail

# Level 2: Configure THIS machine as a Tailscale exit node.
#
# Usage:
#   TS_AUTHKEY=tskey-xxxx TS_HOSTNAME=my-exit ./scripts/linux/level2-exit-node.sh
#
# Variables:
TS_AUTHKEY="${TS_AUTHKEY:-}"
TS_HOSTNAME="${TS_HOSTNAME:-}"

if [[ -z "${TS_AUTHKEY}" ]]; then
  echo "ERROR: TS_AUTHKEY is required (create a Tailscale auth key)."
  exit 1
fi

echo "==> Enabling IP forwarding"
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1 || true

echo "==> Starting tailscaled (if not running)"
sudo systemctl enable --now tailscaled >/dev/null 2>&1 || true

echo "==> Authenticating + advertising exit node"
if [[ -n "${TS_HOSTNAME}" ]]; then
  sudo tailscale up --authkey="${TS_AUTHKEY}" --hostname="${TS_HOSTNAME}" --advertise-exit-node
else
  sudo tailscale up --authkey="${TS_AUTHKEY}" --advertise-exit-node
fi

echo "NOTE: Approve the exit node in the Tailscale admin console."
echo "✅ Level 2 exit node configured."

#!/usr/bin/env bash
set -euo pipefail

# Level 1: Side-by-side Tailscale + VPN
# - Tailscale routes 100.x only
# - VPN owns internet default route
#
# Usage:
#   VPN_IF=wg0 ./scripts/linux/level1-side-by-side.sh
#
# Variables:
VPN_IF="${VPN_IF:-wg0}"

echo "==> Bringing up Tailscale (DNS disabled so VPN can own DNS)"
sudo tailscale up --accept-dns=false

echo "==> Bringing up WireGuard VPN interface: ${VPN_IF}"
sudo wg-quick up "${VPN_IF}"

echo "==> Routes (default + tailscale)"
ip route | grep -E "default|100\." || true

echo "✅ Level 1 configured."

#!/usr/bin/env bash
set -euo pipefail

# Level 3: VPN inside Tailscale (advanced).
# This script prepares a node to ACCEPT routes from a subnet-router / vpn server.
#
# Usage:
#   ./scripts/linux/level3-vpn-over-tailscale.sh
#
echo "==> Bringing up Tailscale (accept routes)"
sudo tailscale up --accept-routes --accept-dns=false

echo "==> Check routes"
ip route | grep -E "100\.|via" || true

echo "✅ Level 3 client prepared."

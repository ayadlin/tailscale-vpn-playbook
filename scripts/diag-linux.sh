#!/usr/bin/env bash
set -euo pipefail

echo "==> Date"
date || true

echo "==> OS"
uname -a || true

echo "==> Interfaces"
ip -brief addr 2>/dev/null || ifconfig 2>/dev/null || true

echo "==> Routes (IPv4)"
ip route 2>/dev/null || netstat -rn 2>/dev/null || true

echo "==> Default route"
ip route 2>/dev/null | grep default || true

echo "==> Tailscale status"
tailscale status 2>/dev/null || echo "tailscale not found or not running"

echo "==> Tailscale IP"
tailscale ip -4 2>/dev/null || true

echo "==> DNS (systemd-resolved if present)"
resolvectl status 2>/dev/null || true
echo "==> /etc/resolv.conf"
cat /etc/resolv.conf 2>/dev/null || true

echo "==> WireGuard"
wg show 2>/dev/null || echo "wg not found or no interfaces"

echo "✅ Diagnostic snapshot complete."

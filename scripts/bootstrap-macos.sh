#!/usr/bin/env bash
set -euo pipefail

# Bootstrap macOS: installs required tools via Homebrew.
#
# Usage:
#   ./scripts/bootstrap-macos.sh
#
# Notes:
# - Tailscale on macOS is typically installed via DMG or Homebrew cask.
# - WireGuard is usually via the WireGuard app (App Store) or command-line tools.
#
command -v brew >/dev/null 2>&1 || { echo "ERROR: Homebrew not found. Install from https://brew.sh"; exit 1; }

echo "==> Installing utilities"
brew install wireguard-tools || true

echo "==> Installing Tailscale (cask)"
brew install --cask tailscale || true

echo "==> Done. Next:"
echo "  - Open Tailscale app and sign in, or use: tailscale up --accept-dns=false"
echo "  - If using WireGuard, import config into the WireGuard app, or use wg-quick if available."

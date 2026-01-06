#!/usr/bin/env bash
set -euo pipefail

# Bootstrap Linux: install Tailscale + WireGuard + OpenVPN (optional) and enable services.
#
# Tested families: Debian/Ubuntu, Fedora/RHEL, Arch (best-effort).
#
# Usage:
#   ./scripts/bootstrap-linux.sh
#
# Optional env vars:
#   INSTALL_OPENVPN=1   (default 0)
#
INSTALL_OPENVPN="${INSTALL_OPENVPN:-0}"

echo "==> Detecting distro..."
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  DISTRO="${ID:-unknown}"
else
  DISTRO="unknown"
fi
echo "Distro: ${DISTRO}"

install_pkg_debian() {
  sudo apt-get update
  sudo apt-get install -y curl ca-certificates gnupg lsb-release
  sudo apt-get install -y wireguard wireguard-tools
  if [[ "${INSTALL_OPENVPN}" == "1" ]]; then
    sudo apt-get install -y openvpn
  fi
}

install_pkg_fedora() {
  sudo dnf install -y curl ca-certificates wireguard-tools
  if [[ "${INSTALL_OPENVPN}" == "1" ]]; then
    sudo dnf install -y openvpn
  fi
}

install_pkg_arch() {
  sudo pacman -Sy --noconfirm curl ca-certificates wireguard-tools
  if [[ "${INSTALL_OPENVPN}" == "1" ]]; then
    sudo pacman -S --noconfirm openvpn
  fi
}

case "${DISTRO}" in
  ubuntu|debian)
    install_pkg_debian
    ;;
  fedora|rhel|centos)
    install_pkg_fedora
    ;;
  arch|manjaro)
    install_pkg_arch
    ;;
  *)
    echo "WARN: Unknown distro. Attempting Debian-style packages."
    install_pkg_debian || true
    ;;
esac

echo "==> Installing Tailscale"
curl -fsSL https://tailscale.com/install.sh | sh

echo "==> Enabling tailscaled"
sudo systemctl enable --now tailscaled >/dev/null 2>&1 || true

echo "==> Done. Next:"
echo "  - Authenticate: sudo tailscale up --accept-dns=false"
echo "  - Configure WireGuard in /etc/wireguard/ (see examples/)"

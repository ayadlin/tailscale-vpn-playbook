#!/usr/bin/env bash
set -euo pipefail

# Interactive launcher for common setups.
# Linux/macOS focused; Windows users should run PowerShell scripts in scripts/windows/.
#
# Usage:
#   ./install.sh
#
# Environment variables (as needed):
#   VPN_IF=wg0
#   TS_AUTHKEY=tskey-xxxxxx
#   TS_HOSTNAME=my-exit
#

echo "Tailscale + VPN Coexistence Playbook (v2)"
echo
echo "Choose an option:"
echo "  1) Level 1 — Side-by-side (Tailscale + VPN) [Linux/macOS]"
echo "  2) Level 2 — Configure THIS machine as Exit Node [Linux]"
echo "  3) Level 3 — Prepare client to accept routes [Linux/macOS]"
echo "  4) Docker Compose Exit Node (start)"
echo "  5) Kubernetes: apply exit-node manifest"
echo "  6) Kubernetes: apply subnet-router manifest"
echo "  q) Quit"
echo
read -rp "Selection: " choice

case "${choice}" in
  1)
    bash scripts/linux/level1-side-by-side.sh
    ;;
  2)
    bash scripts/linux/level2-exit-node.sh
    ;;
  3)
    bash scripts/linux/level3-vpn-over-tailscale.sh
    ;;
  4)
    if [[ -z "${TS_AUTHKEY:-}" ]]; then
      echo "ERROR: TS_AUTHKEY must be set for Docker exit node."
      echo "Example: TS_AUTHKEY=tskey-xxx ./install.sh"
      exit 1
    fi
    (cd docker && docker compose up -d)
    echo "Now run: docker exec -it tailscale-exit-node tailscale up --advertise-exit-node"
    ;;
  5)
    kubectl apply -f k8s/tailscale-exit-node.yaml
    echo "Then run: kubectl exec -it deploy/tailscale-exit-node -- tailscale up --advertise-exit-node"
    ;;
  6)
    kubectl apply -f k8s/tailscale-subnet-router.yaml
    echo "NOTE: Edit k8s/tailscale-subnet-router.yaml ROUTES first."
    ;;
  q|Q)
    echo "Bye."
    ;;
  *)
    echo "Unknown selection"
    exit 1
    ;;
esac

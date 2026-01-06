# Variables Reference (Copy/Paste Friendly)

This repo is designed so users only need to change **variables**, not logic.

## Common variables

### Tailscale
- `TS_AUTHKEY` (required for unattended auth)
  - Format: `tskey-...`
  - Create in Tailscale admin console
- `TS_HOSTNAME` (optional)
  - A stable name for your node

### Level 1 (side-by-side)
- `VPN_IF` (Linux/macOS)
  - Default: `wg0`
  - The WireGuard interface name used by `wg-quick`

## Where to set variables

### Linux/macOS

```bash
export TS_AUTHKEY=tskey-xxxx
export TS_HOSTNAME=my-exit
export VPN_IF=wg0
```

Run:

```bash
./install.sh
```

### Windows
Set variables in the prompt when asked by `install.ps1`, or edit script defaults.

### Docker
Option 1: export variables

```bash
export TS_AUTHKEY=tskey-xxxx
export TS_HOSTNAME=docker-exit
cd docker
docker compose up -d
```

Option 2: use an env file

```bash
cp ../configs/.env.example .env
# edit .env
docker compose up -d
```

### Kubernetes
Create secret:

```bash
kubectl create secret generic tailscale-auth --from-literal=TS_AUTHKEY=tskey-xxxx
```

Edit `ROUTES` in `k8s/tailscale-subnet-router.yaml`.

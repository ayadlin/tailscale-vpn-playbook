# Troubleshooting Playbook (If X, run Y)

## Quick diagnostics

### Linux/macOS
```bash
./scripts/diag-linux.sh
```

### Windows
```powershell
.\scripts\diag-windows.ps1
```

---

## Symptom → Commands → Fix

### 1) Internet drops when you connect both
**Run:**
- Linux/macOS: `ip route | grep default`
- Windows: `Get-NetRoute | ? {$_.DestinationPrefix -eq '0.0.0.0/0'}`

**Likely cause:** both Tailscale and VPN installed a default route.

**Fix:**
- Prefer VPN to own default route for Level 1
- Ensure Tailscale is not acting as exit node:
  - `tailscale up --exit-node=`

---

### 2) DNS broken / sites won’t resolve
**Run:**
- macOS: `scutil --dns`
- Linux: `resolvectl status` (systemd) or `cat /etc/resolv.conf`
- Windows: `Get-DnsClientServerAddress`

**Fix:**
- If your VPN sets DNS, run:
  - `tailscale up --accept-dns=false`

---

### 3) Can’t reach tailnet peers while VPN is on
**Run:**
- `tailscale status`
- Ping a peer: `ping 100.x.y.z`

**Fix:**
- Confirm tailnet routes exist:
  - Linux: `ip route | grep 100.`
- If your VPN client is in “lockdown” mode, allow local LAN / split tunnel.

---

### 4) Exit node works but some apps leak DNS
**Run:**
- Check DNS servers (OS commands above)

**Fix:**
- Force DNS to the exit node (or a trusted resolver) and disable competing DNS.

---

### 5) Kubernetes exit node starts but routing doesn’t work
**Run:**
- `kubectl logs deploy/tailscale-exit-node`
- Ensure privileges / NET_ADMIN permitted.

**Fix:**
- Cluster policy must allow privileged + hostNetwork.
- Approve node in Tailscale admin console.

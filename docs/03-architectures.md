# Architectures (3 Levels)

## Level 1 — Side‑by‑side (Recommended)

- Tailscale for private access (100.x)
- VPN for internet

```mermaid
graph LR
  A[Client] -->|Tailscale 100.x| B[Private Devices]
  A -->|VPN default route| C[Internet]
```

### Key settings
- Keep VPN as default route (`0.0.0.0/0`)
- Keep Tailscale from overriding DNS unless you want MagicDNS:
  - `tailscale up --accept-dns=false`

---

## Level 2 — Tailscale Exit Node (VPN replacement)

```mermaid
graph LR
  A[Client] -->|Tailscale| E[Exit Node]
  E --> I[Internet]
```

### Key settings
- Exit node advertises exit routing
- Client selects exit node

---

## Level 3 — VPN inside Tailscale (Advanced)

```mermaid
graph LR
  A[Client] -->|Tailscale| V[VPN Server behind NAT]
  V --> S[Private Subnet]
```

### Key settings
- VPN binds to tailscale interface/IP
- Tailscale handles reachability + identity

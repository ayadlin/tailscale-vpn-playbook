# Decision Tree — What Should I Use?

Use this page when you’re not sure which level you need.

```mermaid
flowchart TD
  A[What do you want?] --> B{Private access to devices?}
  B -->|Yes| C[Tailscale]
  B -->|No| D{Hide internet traffic / geo?}
  D -->|Yes| E[Traditional VPN]
  D -->|No| F{Want one tool for both?}
  F -->|Yes| G[Tailscale Exit Node]
  F -->|No| H{VPN server behind NAT?}
  H -->|Yes| I[VPN inside Tailscale]
  H -->|No| J[Level 1 side-by-side]
```

## Practical mapping

- **Level 1** if you use a commercial VPN or already have a VPN endpoint
- **Level 2** if you control a VPS/home server and want one consistent “VPN”
- **Level 3** if your VPN server is behind NAT or you need a hub‑and‑spoke inside a mesh

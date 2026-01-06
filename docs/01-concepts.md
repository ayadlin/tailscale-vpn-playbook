# Core Concepts

## Mental model

- **Tailscale** = identity-based WireGuard mesh; routes **100.64.0.0/10** (100.x)
- **Traditional VPN (WireGuard/OpenVPN/commercial)** = centralized tunnel; often sets **default route** (`0.0.0.0/0`)

### Golden rule
> Only **one thing** should own the **default route**.

That’s why the recommended setup is usually:
- VPN owns internet default route (privacy / geo)
- Tailscale routes only its own IP range (private device access)

## Common collisions

- **DNS ownership**: both try to set DNS → name resolution breaks
- **Default route**: both set 0.0.0.0/0 → internet drops / flaps
- **Split tunneling**: mis-specified AllowedIPs or route advertisements

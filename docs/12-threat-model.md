# Threat Model & Privacy Notes

## What Tailscale protects
- Encrypts traffic between authenticated devices (WireGuard)
- Provides identity + device-based access control (ACLs)
- NAT traversal without exposing inbound ports (often)

## What Tailscale does NOT protect
- It is not a general “anonymity” system by itself
- Your ISP can still see you are connecting to DERP / peers (metadata)
- Exit-node traffic egresses from the exit node (exit node operator can observe metadata)

## Exit node privacy caveats
- Exit node operator may observe:
  - destination IPs
  - timing/volume metadata
- Prefer exit nodes you control.

## DNS leak checks
- Ensure only one DNS owner.
- With commercial VPNs, disable Tailscale DNS (`--accept-dns=false`).

## Kill-switch notes
- Some VPN clients enforce kill-switch/lockdown that blocks other tunnels.
- If you need Tailscale while VPN is on, allow split tunnel / local access.

# Security Hardening Checklist

## Tailscale
- [ ] Enable **SSO** (if available)
- [ ] Use **device posture** / managed devices (if on business plan)
- [ ] Create **ACLs** (deny-by-default)
- [ ] Disable key reuse unless needed
- [ ] Rotate auth keys periodically
- [ ] Enable **MFA** on the identity provider

## Exit Node / Subnet Router
- [ ] Apply OS updates automatically
- [ ] Restrict SSH (keys only, no password)
- [ ] Firewall:
  - allow inbound: SSH (optional), Tailscale (outbound)
  - deny unsolicited inbound services
- [ ] Log routing changes (`journalctl`, syslog)
- [ ] Use dedicated server account (least privilege)

## DNS
- [ ] Ensure exactly one “DNS owner” for clients
- [ ] Prefer split DNS for internal domains

## VPN (WireGuard/OpenVPN)
- [ ] Strong keys, rotate regularly
- [ ] Limit AllowedIPs to what you need
- [ ] Keep server configs in a secrets store

## Windows
- [ ] Use Windows Firewall with a default-deny inbound profile
- [ ] Keep Tailscale client updated

## macOS
- [ ] Verify DNS order after connecting VPN + Tailscale
- [ ] Avoid installing multiple “always-on” VPNs simultaneously

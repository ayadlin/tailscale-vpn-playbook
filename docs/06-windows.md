# Windows (11/10)

## Install
- Install Tailscale (MSI)
- Install your VPN client (WireGuard or OpenVPN)

## Level 1 — Side‑by‑side (recommended)

```powershell
tailscale up --accept-dns=false
```

Then connect your VPN normally.

## Verify

```powershell
tailscale status
Get-NetRoute -AddressFamily IPv4 | ? {$_.DestinationPrefix -eq '0.0.0.0/0'}
Get-DnsClientServerAddress -AddressFamily IPv4
```

## Common fix: DNS
If name resolution breaks, ensure only one system is changing DNS:
- Keep `--accept-dns=false` if the traditional VPN sets DNS.

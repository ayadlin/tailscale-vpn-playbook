<#
Level 3: VPN inside Tailscale (Windows client)

Goal:
- Accept advertised routes (subnet router / vpn server)
- Keep DNS stable (often disable tailscale DNS)

Usage:
  .\scripts\windows\level3-vpn-over-tailscale.ps1
#>

Write-Host "==> Tailscale up (accept routes)"
tailscale up --accept-routes --accept-dns=false

Write-Host "==> Status"
tailscale status

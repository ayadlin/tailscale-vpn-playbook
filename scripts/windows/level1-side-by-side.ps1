<#
Level 1: Side-by-side Tailscale + VPN (Windows)

Goal:
- Tailscale routes only tailnet (100.x)
- Traditional VPN owns default route + DNS

Usage (PowerShell as Administrator):
  .\scripts\windows\level1-side-by-side.ps1

If you use a VPN that forces DNS, keep Tailscale DNS disabled:
  tailscale up --accept-dns=false
#>

Write-Host "==> Tailscale up (DNS disabled so VPN can own DNS)"
tailscale up --accept-dns=false

Write-Host "==> Verify default route + tailscale"
Get-NetRoute -AddressFamily IPv4 | ? {$_.DestinationPrefix -eq '0.0.0.0/0'} | Format-Table -AutoSize
tailscale status

<#
Bootstrap Windows: install Tailscale + WireGuard + OpenVPN (optional) using winget.
Run PowerShell as Administrator.

Usage:
  .\scripts\bootstrap-windows.ps1

Optional:
  $env:INSTALL_OPENVPN="1"
#>

$installOpenVPN = $env:INSTALL_OPENVPN
if (-not $installOpenVPN) { $installOpenVPN = "0" }

Write-Host "==> Installing Tailscale"
winget install --id Tailscale.Tailscale -e --source winget

Write-Host "==> Installing WireGuard"
winget install --id WireGuard.WireGuard -e --source winget

if ($installOpenVPN -eq "1") {
  Write-Host "==> Installing OpenVPN"
  winget install --id OpenVPNTechnologies.OpenVPN -e --source winget
}

Write-Host "==> Done. Next:"
Write-Host "  - Start Tailscale and sign in, then run: tailscale up --accept-dns=false"

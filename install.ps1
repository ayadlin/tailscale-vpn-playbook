<#
Interactive launcher for Windows (mirrors install.sh)

Run in PowerShell (preferably as Administrator):
  .\install.ps1

Notes:
- Level 1 expects you to connect your traditional VPN separately (WireGuard/OpenVPN/commercial).
- Level 2 selects an existing Tailscale exit node (client-side).
- Level 3 prepares the client to accept advertised routes.
#>

Write-Host "Tailscale + VPN Coexistence Playbook (v3)"
Write-Host ""
Write-Host "Choose an option:"
Write-Host "  1) Level 1 — Side-by-side (Tailscale + VPN) [Windows]"
Write-Host "  2) Level 2 — Use a Tailscale Exit Node [Windows client]"
Write-Host "  3) Level 3 — Accept advertised routes [Windows]"
Write-Host "  q) Quit"
Write-Host ""

$choice = Read-Host "Selection"

switch ($choice) {
  "1" {
    & .\scripts\windows\level1-side-by-side.ps1
  }
  "2" {
    $exitNode = Read-Host "Enter Exit Node hostname (as shown in 'tailscale status')"
    & .\scripts\windows\level2-exit-node.ps1 -ExitNode $exitNode
  }
  "3" {
    & .\scripts\windows\level3-vpn-over-tailscale.ps1
  }
  "q" {
    Write-Host "Bye."
  }
  default {
    Write-Host "Unknown selection"
    exit 1
  }
}

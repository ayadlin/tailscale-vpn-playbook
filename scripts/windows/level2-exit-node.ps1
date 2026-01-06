<#
Level 2: Use a Tailscale Exit Node (Windows client)

Usage:
  $ExitNode = "my-exit-node"
  .\scripts\windows\level2-exit-node.ps1 -ExitNode $ExitNode
#>

param(
  [Parameter(Mandatory=$true)]
  [string]$ExitNode
)

Write-Host "==> Enabling Exit Node: $ExitNode"
tailscale up --exit-node=$ExitNode --accept-dns=true

Write-Host "==> Verify"
tailscale status
Get-NetRoute -AddressFamily IPv4 | ? {$_.DestinationPrefix -eq '0.0.0.0/0'} | Format-Table -AutoSize

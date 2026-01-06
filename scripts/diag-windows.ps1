Write-Host "==> Date"
Get-Date

Write-Host "==> Interfaces"
Get-NetIPConfiguration | Format-Table -AutoSize

Write-Host "==> Default route"
Get-NetRoute -AddressFamily IPv4 | ? {$_.DestinationPrefix -eq '0.0.0.0/0'} | Format-Table -AutoSize

Write-Host "==> DNS"
Get-DnsClientServerAddress -AddressFamily IPv4 | Format-Table -AutoSize

Write-Host "==> Tailscale status"
tailscale status

Write-Host "==> Routes summary"
Get-NetRoute -AddressFamily IPv4 | Sort-Object -Property DestinationPrefix | Select-Object -First 50 | Format-Table -AutoSize

Write-Host "✅ Diagnostic snapshot complete."

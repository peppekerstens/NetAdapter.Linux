param(
    [string] $AdapterName = 'eth0'
)
<#
.SYNOPSIS
    Toggle a network adapter down and back up (bounce).
.DESCRIPTION
    Demonstrates Enable-NetAdapter and Disable-NetAdapter with -WhatIf.
    Run without -WhatIf to actually cycle the adapter (requires root/sudo).
.EXPECTED OUTPUT
    WhatIf messages describing what would happen.
#>

Write-Host "Simulating adapter bounce for: $AdapterName" -ForegroundColor Cyan
Disable-NetAdapter -Name $AdapterName -WhatIf
Enable-NetAdapter  -Name $AdapterName -WhatIf

Write-Host "`nCurrent status:" -ForegroundColor Cyan
Get-NetAdapter -Name $AdapterName |
    Select-Object Name, Status, LinkSpeed |
    Format-Table -AutoSize

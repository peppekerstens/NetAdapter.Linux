param()
<#
.SYNOPSIS
    Network adapter health report — lists all adapters with stats and flags any with errors.
.DESCRIPTION
    Joins Get-NetAdapter and Get-NetAdapterStatistics to produce a health summary.
    Highlights adapters with RX or TX errors.
.EXPECTED OUTPUT
    A health report table. Adapters with errors are flagged.
#>

$adapters = Get-NetAdapter
$stats    = Get-NetAdapterStatistics

$report = foreach ($a in $adapters) {
    $s = $stats | Where-Object { $_.Name -eq $a.Name }
    [PSCustomObject]@{
        Name           = $a.Name
        Status         = $a.Status
        LinkSpeed      = $a.LinkSpeed
        ReceivedMB     = if ($s) { [math]::Round($s.ReceivedBytes / 1MB, 1) } else { 'n/a' }
        SentMB         = if ($s) { [math]::Round($s.SentBytes / 1MB, 1) } else { 'n/a' }
        RxErrors       = if ($s) { $s.ReceivedErrors } else { 'n/a' }
        TxErrors       = if ($s) { $s.OutboundErrors } else { 'n/a' }
        Health         = if ($s -and ($s.ReceivedErrors -gt 0 -or $s.OutboundErrors -gt 0)) {
                             'WARNING'
                         } elseif ($a.Status -ne 'Up') {
                             'Down'
                         } else {
                             'OK'
                         }
    }
}

$report | Format-Table -AutoSize

$issues = $report | Where-Object { $_.Health -ne 'OK' }
if ($issues) {
    Write-Warning "Adapters with issues: $($issues.Name -join ', ')"
} else {
    Write-Host "All adapters healthy." -ForegroundColor Green
}

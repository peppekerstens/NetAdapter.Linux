param()
<#
.SYNOPSIS
    Show network adapter traffic statistics.
.DESCRIPTION
    Uses Get-NetAdapterStatistics to display RX/TX bytes and packet counts.
    Useful for monitoring interface throughput at a point in time.
.EXPECTED OUTPUT
    A table with adapter name, received/sent bytes and packet counts.
#>

Get-NetAdapterStatistics |
    Select-Object Name,
        @{N='ReceivedMB'; E={ [math]::Round($_.ReceivedBytes / 1MB, 2) }},
        @{N='SentMB';     E={ [math]::Round($_.SentBytes / 1MB, 2) }},
        ReceivedUnicastPackets,
        SentUnicastPackets,
        ReceivedErrors,
        OutboundErrors |
    Format-Table -AutoSize

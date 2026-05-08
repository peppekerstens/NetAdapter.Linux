param()
<#
.SYNOPSIS
    List all network adapters with their status and speed.
.DESCRIPTION
    Uses Get-NetAdapter to display a summary of all network interfaces.
    On Windows: uses the built-in NetAdapter module.
    On Linux: uses NetAdapter.Linux.
.EXPECTED OUTPUT
    A table with Name, Status, LinkSpeed, MacAddress for each adapter.
#>

Get-NetAdapter |
    Select-Object Name, Status, LinkSpeed, MacAddress, Mtu |
    Format-Table -AutoSize

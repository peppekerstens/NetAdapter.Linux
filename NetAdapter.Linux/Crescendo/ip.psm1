# NetAdapter.Linux — private ip wrapper
# Crescendo configuration: ip.crescendo.json
# Hand-written for reliability; mirrors the Crescendo JSON spec exactly.
# NOT exported — loaded as a nested module from NetAdapter.Linux.psm1.

function Get-IpLink {
    <#
    .SYNOPSIS
        Gets network link information for all interfaces.
    .DESCRIPTION
        Private helper. Wraps 'ip -json link show' or 'ip -s -json link show'.
        Called by Get-NetAdapter and Get-NetAdapterStatistics.
    .PARAMETER Statistics
        When specified, includes per-interface RX/TX statistics (ip -s).
    #>
    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSObject[]])]
    param(
        [Parameter()]
        [switch] $Statistics
    )
    process {
        $ipArgs = if ($Statistics) { @('-s', '-json', 'link', 'show') } else { @('-json', 'link', 'show') }
        $raw = & ip @ipArgs 2>&1
        if ($LASTEXITCODE -ne 0) {
            $ex = [System.InvalidOperationException]::new("ip link show failed: $raw")
            $er = [System.Management.Automation.ErrorRecord]::new(
                $ex, 'NetAdapter.Linux.IpLinkFailed',
                [System.Management.Automation.ErrorCategory]::InvalidOperation, $null)
            $PSCmdlet.ThrowTerminatingError($er)
        }
        $raw | ConvertFrom-Json
    }
}

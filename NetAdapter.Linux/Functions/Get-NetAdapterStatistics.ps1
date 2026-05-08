function Get-NetAdapterStatistics {
    <#
    .SYNOPSIS
        Gets the statistics for the network adapters.
    .DESCRIPTION
        Returns RX/TX byte, packet, error, and drop counts from 'ip -s -json link show'.
    .PARAMETER Name
        Wildcard filter on adapter name. Defaults to all adapters.
    .PARAMETER InterfaceIndex
        Filter by interface index.
    .EXAMPLE
        Get-NetAdapterStatistics
    .EXAMPLE
        Get-NetAdapterStatistics -Name eth0
    #>
    [CmdletBinding(DefaultParameterSetName = 'ByName')]
    param(
        [Parameter(ParameterSetName = 'ByName', Position = 0, ValueFromPipelineByPropertyName)]
        [SupportsWildcards()]
        [string] $Name = '*',

        [Parameter(ParameterSetName = 'ByIndex')]
        [uint32] $InterfaceIndex
    )
    process {
        if (-not (Get-Command ip -ErrorAction SilentlyContinue)) {
            $ex = [System.InvalidOperationException]::new(
                "The 'ip' command was not found. Install iproute2: apt install iproute2")
            $er = [System.Management.Automation.ErrorRecord]::new(
                $ex, 'NetAdapter.Linux.IpNotFound',
                [System.Management.Automation.ErrorCategory]::NotInstalled, $null)
            $PSCmdlet.ThrowTerminatingError($er)
        }

        $json = ip -s -json link show 2>&1
        if ($LASTEXITCODE -ne 0) {
            $ex = [System.InvalidOperationException]::new("ip -s link show failed: $json")
            $er = [System.Management.Automation.ErrorRecord]::new(
                $ex, 'NetAdapter.Linux.IpLinkStatsFailed',
                [System.Management.Automation.ErrorCategory]::InvalidOperation, $null)
            $PSCmdlet.ThrowTerminatingError($er)
        }

        $links = $json | ConvertFrom-Json

        foreach ($link in $links) {
            if ($PSCmdlet.ParameterSetName -eq 'ByIndex' -and $link.ifindex -ne $InterfaceIndex) {
                continue
            }
            if ($PSCmdlet.ParameterSetName -eq 'ByName' -and $link.ifname -notlike $Name) {
                continue
            }

            $rx = $link.stats64.rx
            $tx = $link.stats64.tx

            [PSCustomObject]@{
                PSTypeName              = 'NetAdapter.Linux.NetAdapterStatistics'
                Name                    = $link.ifname
                InterfaceAlias          = $link.ifname
                InterfaceIndex          = [uint32]$link.ifindex
                ReceivedBytes           = [uint64]$rx.bytes
                ReceivedUnicastPackets  = [uint64]$rx.packets
                ReceivedErrors          = [uint64]$rx.errors
                ReceivedDiscardedPackets = [uint64]$rx.dropped
                SentBytes               = [uint64]$tx.bytes
                SentUnicastPackets      = [uint64]$tx.packets
                OutboundErrors          = [uint64]$tx.errors
                OutboundDiscardedPackets = [uint64]$tx.dropped
            }
        }
    }
}

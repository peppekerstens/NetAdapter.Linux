function Get-NetAdapter {
    <#
    .SYNOPSIS
        Gets the basic network adapter properties.
    .DESCRIPTION
        Returns network adapter information from the Linux kernel via 'ip -json link show'.
        Supports filtering by Name (wildcard) and by physical adapter only.
    .PARAMETER Name
        Wildcard filter on adapter name. Defaults to all adapters.
    .PARAMETER InterfaceIndex
        Filter by interface index (ifIndex).
    .PARAMETER Physical
        Return only physical adapters (excludes loopback, virtual, tunnel interfaces).
    .EXAMPLE
        Get-NetAdapter
    .EXAMPLE
        Get-NetAdapter -Name 'eth*'
    .EXAMPLE
        Get-NetAdapter -Physical
    #>
    [CmdletBinding(DefaultParameterSetName = 'ByName')]
    param(
        [Parameter(ParameterSetName = 'ByName', Position = 0, ValueFromPipelineByPropertyName)]
        [SupportsWildcards()]
        [string] $Name = '*',

        [Parameter(ParameterSetName = 'ByIndex')]
        [uint32] $InterfaceIndex,

        [Parameter()]
        [switch] $Physical
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

        $json = ip -json link show 2>&1
        if ($LASTEXITCODE -ne 0) {
            $ex = [System.InvalidOperationException]::new("ip link show failed: $json")
            $er = [System.Management.Automation.ErrorRecord]::new(
                $ex, 'NetAdapter.Linux.IpLinkFailed',
                [System.Management.Automation.ErrorCategory]::InvalidOperation, $null)
            $PSCmdlet.ThrowTerminatingError($er)
        }

        $links = $json | ConvertFrom-Json

        foreach ($link in $links) {
            # Filter by index
            if ($PSCmdlet.ParameterSetName -eq 'ByIndex' -and $link.ifindex -ne $InterfaceIndex) {
                continue
            }

            # Filter by name (wildcard)
            if ($PSCmdlet.ParameterSetName -eq 'ByName' -and $link.ifname -notlike $Name) {
                continue
            }

            # Filter physical: exclude loopback, virtual, tunnel types
            if ($Physical) {
                $linkType = $link.link_type
                if ($linkType -eq 'loopback' -or $linkType -eq 'none') { continue }
                if ($link.ifname -match '^(lo|docker|br-|virbr|veth|tun|tap|dummy)') { continue }
            }

            # Parse link speed from operstate and link_info if available
            $speedMbps = 0
            $speedFile = "/sys/class/net/$($link.ifname)/speed"
            if (Test-Path $speedFile) {
                $speedVal = Get-Content $speedFile -ErrorAction SilentlyContinue
                if ($speedVal -match '^\d+$' -and [int]$speedVal -gt 0) {
                    $speedMbps = [int]$speedVal
                }
            }

            # Map operstate to status
            $status = switch ($link.operstate) {
                'UP'      { 'Up' }
                'DOWN'    { 'Disconnected' }
                'UNKNOWN' { 'Up' }  # many virtual/loopback report UNKNOWN but are usable
                default   { $link.operstate }
            }

            # Determine media connection state
            $mediaState = if ($link.flags -contains 'UP') { 'Connected' } else { 'Disconnected' }

            [PSCustomObject]@{
                PSTypeName          = 'NetAdapter.Linux.NetAdapter'
                Name                = $link.ifname
                InterfaceAlias      = $link.ifname
                InterfaceIndex      = [uint32]$link.ifindex
                InterfaceDescription = if ($link.ifalias) { $link.ifalias } else { $link.ifname }
                MacAddress          = $link.address
                Status              = $status
                MediaConnectionState = $mediaState
                LinkSpeed           = if ($speedMbps -gt 0) { "$($speedMbps) Mbps" } else { 'Unknown' }
                FullDuplex          = $true
                DriverInformation   = $link.link_type
                Flags               = $link.flags -join ', '
                Mtu                 = [uint32]$link.mtu
                ifIndex             = [uint32]$link.ifindex
            }
        }
    }
}

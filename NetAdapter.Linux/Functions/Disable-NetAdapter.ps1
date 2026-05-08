function Disable-NetAdapter {
    <#
    .SYNOPSIS
        Disables a network adapter.
    .DESCRIPTION
        Takes a network adapter down using 'ip link set <name> down'. Requires root/sudo.
    .PARAMETER Name
        Name of the adapter to disable. Accepts pipeline input from Get-NetAdapter.
    .PARAMETER InterfaceIndex
        Interface index of the adapter to disable.
    .EXAMPLE
        Disable-NetAdapter -Name eth0
    .EXAMPLE
        Get-NetAdapter -Name eth0 | Disable-NetAdapter -WhatIf
    #>
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ByName',
                   ConfirmImpact = 'High')]
    param(
        [Parameter(ParameterSetName = 'ByName', Mandatory, Position = 0,
                   ValueFromPipelineByPropertyName)]
        [string] $Name,

        [Parameter(ParameterSetName = 'ByIndex', Mandatory,
                   ValueFromPipelineByPropertyName)]
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

        $_name = $Name
        if ($PSCmdlet.ParameterSetName -eq 'ByIndex') {
            $adapter = Get-NetAdapter | Where-Object { $_.InterfaceIndex -eq $InterfaceIndex }
            if (-not $adapter) {
                $ex = [System.ArgumentException]::new(
                    "No adapter found with InterfaceIndex $InterfaceIndex")
                $er = [System.Management.Automation.ErrorRecord]::new(
                    $ex, 'NetAdapter.Linux.AdapterNotFound',
                    [System.Management.Automation.ErrorCategory]::ObjectNotFound, $InterfaceIndex)
                $PSCmdlet.WriteError($er)
                return
            }
            $_name = $adapter.Name
        }

        if ($PSCmdlet.ShouldProcess($_name, 'Disable-NetAdapter (ip link set down)')) {
            $result = ip link set $_name down 2>&1
            if ($LASTEXITCODE -ne 0) {
                $ex = [System.InvalidOperationException]::new(
                    "Failed to disable adapter '$_name': $result")
                $er = [System.Management.Automation.ErrorRecord]::new(
                    $ex, 'NetAdapter.Linux.DisableFailed',
                    [System.Management.Automation.ErrorCategory]::InvalidOperation, $_name)
                $PSCmdlet.WriteError($er)
            }
        }
    }
}

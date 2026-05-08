function Get-NetAdapterHardwareInfo {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterHardwareInfo is not implemented on Linux."
    }
}

function Get-NetAdapterPowerManagement {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterPowerManagement is not implemented on Linux."
    }
}

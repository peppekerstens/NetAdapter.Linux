function Set-NetAdapterPowerManagement {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterPowerManagement is not implemented on Linux."
    }
}

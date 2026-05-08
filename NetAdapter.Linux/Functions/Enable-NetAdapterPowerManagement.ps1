function Enable-NetAdapterPowerManagement {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterPowerManagement is not implemented on Linux."
    }
}

function Disable-NetAdapterPowerManagement {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterPowerManagement is not implemented on Linux."
    }
}

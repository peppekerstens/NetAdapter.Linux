function Set-NetAdapterQos {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterQos is not implemented on Linux."
    }
}

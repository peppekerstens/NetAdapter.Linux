function Set-NetAdapterRsc {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterRsc is not implemented on Linux."
    }
}

function Set-NetAdapterLso {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterLso is not implemented on Linux."
    }
}

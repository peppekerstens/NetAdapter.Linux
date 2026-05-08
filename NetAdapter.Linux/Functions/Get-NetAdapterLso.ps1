function Get-NetAdapterLso {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterLso is not implemented on Linux."
    }
}

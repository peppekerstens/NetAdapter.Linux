function Set-NetAdapterRss {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterRss is not implemented on Linux."
    }
}

function Get-NetAdapterRss {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterRss is not implemented on Linux."
    }
}

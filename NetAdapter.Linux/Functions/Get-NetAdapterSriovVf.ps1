function Get-NetAdapterSriovVf {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterSriovVf is not implemented on Linux."
    }
}

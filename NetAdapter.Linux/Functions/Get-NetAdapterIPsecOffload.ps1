function Get-NetAdapterIPsecOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterIPsecOffload is not implemented on Linux."
    }
}

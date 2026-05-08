function Set-NetAdapterIPsecOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterIPsecOffload is not implemented on Linux."
    }
}

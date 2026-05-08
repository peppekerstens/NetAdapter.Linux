function Disable-NetAdapterIPsecOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterIPsecOffload is not implemented on Linux."
    }
}

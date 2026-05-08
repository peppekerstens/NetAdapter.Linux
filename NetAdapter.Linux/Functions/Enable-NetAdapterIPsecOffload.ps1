function Enable-NetAdapterIPsecOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterIPsecOffload is not implemented on Linux."
    }
}

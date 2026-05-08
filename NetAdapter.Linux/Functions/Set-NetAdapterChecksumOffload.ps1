function Set-NetAdapterChecksumOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterChecksumOffload is not implemented on Linux."
    }
}

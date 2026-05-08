function Get-NetAdapterChecksumOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterChecksumOffload is not implemented on Linux."
    }
}

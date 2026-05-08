function Disable-NetAdapterChecksumOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterChecksumOffload is not implemented on Linux."
    }
}

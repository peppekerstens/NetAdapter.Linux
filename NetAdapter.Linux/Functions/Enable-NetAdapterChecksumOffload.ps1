function Enable-NetAdapterChecksumOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterChecksumOffload is not implemented on Linux."
    }
}

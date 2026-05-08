function Restart-NetAdapter {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Restart-NetAdapter is not implemented on Linux."
    }
}

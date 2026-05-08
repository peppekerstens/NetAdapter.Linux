function Rename-NetAdapter {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Rename-NetAdapter is not implemented on Linux."
    }
}

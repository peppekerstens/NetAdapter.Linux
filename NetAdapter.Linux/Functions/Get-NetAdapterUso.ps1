function Get-NetAdapterUso {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterUso is not implemented on Linux."
    }
}

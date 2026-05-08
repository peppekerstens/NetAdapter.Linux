function Disable-NetAdapterUso {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterUso is not implemented on Linux."
    }
}

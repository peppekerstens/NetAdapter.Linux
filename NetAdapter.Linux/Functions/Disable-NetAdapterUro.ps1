function Disable-NetAdapterUro {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterUro is not implemented on Linux."
    }
}

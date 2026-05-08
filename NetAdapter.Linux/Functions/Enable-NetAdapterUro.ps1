function Enable-NetAdapterUro {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterUro is not implemented on Linux."
    }
}

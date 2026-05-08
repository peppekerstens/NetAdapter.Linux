function Get-NetAdapterUro {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterUro is not implemented on Linux."
    }
}

function Enable-NetAdapterVmq {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterVmq is not implemented on Linux."
    }
}

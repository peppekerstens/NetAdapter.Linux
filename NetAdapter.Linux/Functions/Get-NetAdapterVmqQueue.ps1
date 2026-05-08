function Get-NetAdapterVmqQueue {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterVmqQueue is not implemented on Linux."
    }
}

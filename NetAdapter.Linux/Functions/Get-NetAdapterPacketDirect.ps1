function Get-NetAdapterPacketDirect {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterPacketDirect is not implemented on Linux."
    }
}

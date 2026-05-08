function Set-NetAdapterPacketDirect {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterPacketDirect is not implemented on Linux."
    }
}

function Disable-NetAdapterPacketDirect {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterPacketDirect is not implemented on Linux."
    }
}

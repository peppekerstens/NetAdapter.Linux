function Enable-NetAdapterPacketDirect {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterPacketDirect is not implemented on Linux."
    }
}

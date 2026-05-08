function Disable-NetAdapterEncapsulatedPacketTaskOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterEncapsulatedPacketTaskOffload is not implemented on Linux."
    }
}

function Enable-NetAdapterEncapsulatedPacketTaskOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Enable-NetAdapterEncapsulatedPacketTaskOffload is not implemented on Linux."
    }
}

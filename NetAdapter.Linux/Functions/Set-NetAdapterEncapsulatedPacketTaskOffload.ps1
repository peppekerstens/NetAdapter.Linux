function Set-NetAdapterEncapsulatedPacketTaskOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterEncapsulatedPacketTaskOffload is not implemented on Linux."
    }
}

function Get-NetAdapterEncapsulatedPacketTaskOffload {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterEncapsulatedPacketTaskOffload is not implemented on Linux."
    }
}

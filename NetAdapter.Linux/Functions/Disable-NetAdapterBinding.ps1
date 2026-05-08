function Disable-NetAdapterBinding {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Disable-NetAdapterBinding is not implemented on Linux."
    }
}

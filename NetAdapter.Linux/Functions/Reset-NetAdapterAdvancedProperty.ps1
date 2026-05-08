function Reset-NetAdapterAdvancedProperty {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Reset-NetAdapterAdvancedProperty is not implemented on Linux."
    }
}

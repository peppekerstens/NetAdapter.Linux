function Set-NetAdapterAdvancedProperty {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterAdvancedProperty is not implemented on Linux."
    }
}

function New-NetAdapterAdvancedProperty {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "New-NetAdapterAdvancedProperty is not implemented on Linux."
    }
}

function Remove-NetAdapterAdvancedProperty {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Remove-NetAdapterAdvancedProperty is not implemented on Linux."
    }
}

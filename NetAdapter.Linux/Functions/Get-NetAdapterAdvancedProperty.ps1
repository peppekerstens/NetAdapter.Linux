function Get-NetAdapterAdvancedProperty {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterAdvancedProperty is not implemented on Linux."
    }
}

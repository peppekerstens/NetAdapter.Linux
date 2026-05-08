function Get-NetAdapterDataPathConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Get-NetAdapterDataPathConfiguration is not implemented on Linux."
    }
}

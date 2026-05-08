function Set-NetAdapterDataPathConfiguration {
    [CmdletBinding(SupportsShouldProcess)]
    param([Parameter(ValueFromRemainingArguments)][object[]] $ArgumentList)
    process {
        Write-Warning "Set-NetAdapterDataPathConfiguration is not implemented on Linux."
    }
}

@{
    RootModule        = 'NetAdapter.Linux.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'c3d4e5f6-a7b8-9012-cdef-012345678901'
    Author            = 'Peppe Kerstens'
    Description       = 'PowerShell NetAdapter module for Linux — mirrors the Windows NetAdapter module surface using ip link (iproute2).'
    PowerShellVersion = '7.2'

    FunctionsToExport = @(
        'Disable-NetAdapter',
        'Disable-NetAdapterBinding',
        'Disable-NetAdapterChecksumOffload',
        'Disable-NetAdapterEncapsulatedPacketTaskOffload',
        'Disable-NetAdapterIPsecOffload',
        'Disable-NetAdapterLso',
        'Disable-NetAdapterPacketDirect',
        'Disable-NetAdapterPowerManagement',
        'Disable-NetAdapterQos',
        'Disable-NetAdapterRdma',
        'Disable-NetAdapterRsc',
        'Disable-NetAdapterRss',
        'Disable-NetAdapterSriov',
        'Disable-NetAdapterUro',
        'Disable-NetAdapterUso',
        'Disable-NetAdapterVmq',
        'Enable-NetAdapter',
        'Enable-NetAdapterBinding',
        'Enable-NetAdapterChecksumOffload',
        'Enable-NetAdapterEncapsulatedPacketTaskOffload',
        'Enable-NetAdapterIPsecOffload',
        'Enable-NetAdapterLso',
        'Enable-NetAdapterPacketDirect',
        'Enable-NetAdapterPowerManagement',
        'Enable-NetAdapterQos',
        'Enable-NetAdapterRdma',
        'Enable-NetAdapterRsc',
        'Enable-NetAdapterRss',
        'Enable-NetAdapterSriov',
        'Enable-NetAdapterUro',
        'Enable-NetAdapterUso',
        'Enable-NetAdapterVmq',
        'Get-NetAdapter',
        'Get-NetAdapterAdvancedProperty',
        'Get-NetAdapterBinding',
        'Get-NetAdapterChecksumOffload',
        'Get-NetAdapterDataPathConfiguration',
        'Get-NetAdapterEncapsulatedPacketTaskOffload',
        'Get-NetAdapterHardwareInfo',
        'Get-NetAdapterIPsecOffload',
        'Get-NetAdapterLso',
        'Get-NetAdapterPacketDirect',
        'Get-NetAdapterPowerManagement',
        'Get-NetAdapterQos',
        'Get-NetAdapterRdma',
        'Get-NetAdapterRsc',
        'Get-NetAdapterRss',
        'Get-NetAdapterSriov',
        'Get-NetAdapterSriovVf',
        'Get-NetAdapterStatistics',
        'Get-NetAdapterUro',
        'Get-NetAdapterUso',
        'Get-NetAdapterVmq',
        'Get-NetAdapterVmqQueue',
        'Get-NetAdapterVPort',
        'New-NetAdapterAdvancedProperty',
        'Remove-NetAdapterAdvancedProperty',
        'Rename-NetAdapter',
        'Reset-NetAdapterAdvancedProperty',
        'Restart-NetAdapter',
        'Set-NetAdapter',
        'Set-NetAdapterAdvancedProperty',
        'Set-NetAdapterBinding',
        'Set-NetAdapterChecksumOffload',
        'Set-NetAdapterDataPathConfiguration',
        'Set-NetAdapterEncapsulatedPacketTaskOffload',
        'Set-NetAdapterIPsecOffload',
        'Set-NetAdapterLso',
        'Set-NetAdapterPacketDirect',
        'Set-NetAdapterPowerManagement',
        'Set-NetAdapterQos',
        'Set-NetAdapterRdma',
        'Set-NetAdapterRsc',
        'Set-NetAdapterRss',
        'Set-NetAdapterSriov',
        'Set-NetAdapterUro',
        'Set-NetAdapterUso',
        'Set-NetAdapterVmq'
    )

    AliasesToExport   = @()
    CmdletsToExport   = @()
    VariablesToExport = @()

    PrivateData = @{
        PSData = @{
            Tags         = @('Linux', 'NetAdapter', 'Network', 'iproute2')
            ProjectUri   = 'https://github.com/peppekerstens/NetAdapter.Linux'
            ReleaseNotes = @'
## 0.1.0
- Initial release
- Implemented: Get-NetAdapter, Get-NetAdapterStatistics, Enable-NetAdapter, Disable-NetAdapter
- 74 stubs for NDIS-specific and other NetAdapter cmdlets
'@
        }
    }
}

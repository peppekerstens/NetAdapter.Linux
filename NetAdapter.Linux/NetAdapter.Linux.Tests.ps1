#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.2.0' }

BeforeDiscovery {
    $script:OnLinux = $IsLinux

    $script:ExpectedFunctions = @(
        'Disable-NetAdapter','Disable-NetAdapterBinding','Disable-NetAdapterChecksumOffload',
        'Disable-NetAdapterEncapsulatedPacketTaskOffload','Disable-NetAdapterIPsecOffload',
        'Disable-NetAdapterLso','Disable-NetAdapterPacketDirect','Disable-NetAdapterPowerManagement',
        'Disable-NetAdapterQos','Disable-NetAdapterRdma','Disable-NetAdapterRsc',
        'Disable-NetAdapterRss','Disable-NetAdapterSriov','Disable-NetAdapterUro',
        'Disable-NetAdapterUso','Disable-NetAdapterVmq',
        'Enable-NetAdapter','Enable-NetAdapterBinding','Enable-NetAdapterChecksumOffload',
        'Enable-NetAdapterEncapsulatedPacketTaskOffload','Enable-NetAdapterIPsecOffload',
        'Enable-NetAdapterLso','Enable-NetAdapterPacketDirect','Enable-NetAdapterPowerManagement',
        'Enable-NetAdapterQos','Enable-NetAdapterRdma','Enable-NetAdapterRsc',
        'Enable-NetAdapterRss','Enable-NetAdapterSriov','Enable-NetAdapterUro',
        'Enable-NetAdapterUso','Enable-NetAdapterVmq',
        'Get-NetAdapter','Get-NetAdapterAdvancedProperty','Get-NetAdapterBinding',
        'Get-NetAdapterChecksumOffload','Get-NetAdapterDataPathConfiguration',
        'Get-NetAdapterEncapsulatedPacketTaskOffload','Get-NetAdapterHardwareInfo',
        'Get-NetAdapterIPsecOffload','Get-NetAdapterLso','Get-NetAdapterPacketDirect',
        'Get-NetAdapterPowerManagement','Get-NetAdapterQos','Get-NetAdapterRdma',
        'Get-NetAdapterRsc','Get-NetAdapterRss','Get-NetAdapterSriov','Get-NetAdapterSriovVf',
        'Get-NetAdapterStatistics','Get-NetAdapterUro','Get-NetAdapterUso','Get-NetAdapterVmq',
        'Get-NetAdapterVmqQueue','Get-NetAdapterVPort',
        'New-NetAdapterAdvancedProperty','Remove-NetAdapterAdvancedProperty',
        'Rename-NetAdapter','Reset-NetAdapterAdvancedProperty','Restart-NetAdapter',
        'Set-NetAdapter','Set-NetAdapterAdvancedProperty','Set-NetAdapterBinding',
        'Set-NetAdapterChecksumOffload','Set-NetAdapterDataPathConfiguration',
        'Set-NetAdapterEncapsulatedPacketTaskOffload','Set-NetAdapterIPsecOffload',
        'Set-NetAdapterLso','Set-NetAdapterPacketDirect','Set-NetAdapterPowerManagement',
        'Set-NetAdapterQos','Set-NetAdapterRdma','Set-NetAdapterRsc','Set-NetAdapterRss',
        'Set-NetAdapterSriov','Set-NetAdapterUro','Set-NetAdapterUso','Set-NetAdapterVmq'
    )

    $script:StubFunctions = @(
        'Disable-NetAdapterBinding','Disable-NetAdapterChecksumOffload',
        'Disable-NetAdapterEncapsulatedPacketTaskOffload','Disable-NetAdapterIPsecOffload',
        'Disable-NetAdapterLso','Disable-NetAdapterPacketDirect','Disable-NetAdapterPowerManagement',
        'Disable-NetAdapterQos','Disable-NetAdapterRdma','Disable-NetAdapterRsc',
        'Disable-NetAdapterRss','Disable-NetAdapterSriov','Disable-NetAdapterUro',
        'Disable-NetAdapterUso','Disable-NetAdapterVmq',
        'Enable-NetAdapterBinding','Enable-NetAdapterChecksumOffload',
        'Enable-NetAdapterEncapsulatedPacketTaskOffload','Enable-NetAdapterIPsecOffload',
        'Enable-NetAdapterLso','Enable-NetAdapterPacketDirect','Enable-NetAdapterPowerManagement',
        'Enable-NetAdapterQos','Enable-NetAdapterRdma','Enable-NetAdapterRsc',
        'Enable-NetAdapterRss','Enable-NetAdapterSriov','Enable-NetAdapterUro',
        'Enable-NetAdapterUso','Enable-NetAdapterVmq',
        'Get-NetAdapterAdvancedProperty','Get-NetAdapterBinding','Get-NetAdapterChecksumOffload',
        'Get-NetAdapterDataPathConfiguration','Get-NetAdapterEncapsulatedPacketTaskOffload',
        'Get-NetAdapterHardwareInfo','Get-NetAdapterIPsecOffload','Get-NetAdapterLso',
        'Get-NetAdapterPacketDirect','Get-NetAdapterPowerManagement','Get-NetAdapterQos',
        'Get-NetAdapterRdma','Get-NetAdapterRsc','Get-NetAdapterRss','Get-NetAdapterSriov',
        'Get-NetAdapterSriovVf','Get-NetAdapterUro','Get-NetAdapterUso','Get-NetAdapterVmq',
        'Get-NetAdapterVmqQueue','Get-NetAdapterVPort',
        'New-NetAdapterAdvancedProperty','Remove-NetAdapterAdvancedProperty',
        'Rename-NetAdapter','Reset-NetAdapterAdvancedProperty','Restart-NetAdapter',
        'Set-NetAdapter','Set-NetAdapterAdvancedProperty','Set-NetAdapterBinding',
        'Set-NetAdapterChecksumOffload','Set-NetAdapterDataPathConfiguration',
        'Set-NetAdapterEncapsulatedPacketTaskOffload','Set-NetAdapterIPsecOffload',
        'Set-NetAdapterLso','Set-NetAdapterPacketDirect','Set-NetAdapterPowerManagement',
        'Set-NetAdapterQos','Set-NetAdapterRdma','Set-NetAdapterRsc','Set-NetAdapterRss',
        'Set-NetAdapterSriov','Set-NetAdapterUro','Set-NetAdapterUso','Set-NetAdapterVmq'
    )
}

BeforeAll {
    if ($IsLinux) {
        Import-Module "$PSScriptRoot/NetAdapter.Linux.psd1" -Force
    }
}

Describe 'Module surface' -Skip:(-not $script:OnLinux) {
    It 'exports exactly 78 functions' {
        (Get-Command -Module NetAdapter.Linux | Measure-Object).Count | Should -Be 78
    }

    It 'exports <_>' -ForEach $script:ExpectedFunctions {
        Get-Command -Module NetAdapter.Linux -Name $_ | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-NetAdapter' -Skip:(-not $script:OnLinux) {
    It 'returns at least one adapter' {
        $adapters = Get-NetAdapter
        $adapters | Should -Not -BeNullOrEmpty
    }

    It 'returns objects with expected properties' {
        $adapter = Get-NetAdapter | Select-Object -First 1
        $adapter.Name         | Should -Not -BeNullOrEmpty
        $adapter.InterfaceIndex | Should -BeGreaterThan 0
        $adapter.MacAddress   | Should -Not -BeNullOrEmpty
        $adapter.Status       | Should -Not -BeNullOrEmpty
        $adapter.Mtu          | Should -BeGreaterThan 0
    }

    It 'filters by wildcard name' {
        $all = Get-NetAdapter
        $first = $all | Select-Object -First 1
        $filtered = Get-NetAdapter -Name $first.Name
        $filtered.Name | Should -Be $first.Name
    }

    It 'returns lo adapter (loopback is always present)' {
        $lo = Get-NetAdapter -Name 'lo'
        $lo | Should -Not -BeNullOrEmpty
    }

    It 'Physical switch excludes loopback' {
        $physical = Get-NetAdapter -Physical
        $names = $physical | Select-Object -ExpandProperty Name
        $names | Should -Not -Contain 'lo'
    }
}

Describe 'Get-NetAdapterStatistics' -Skip:(-not $script:OnLinux) {
    It 'returns statistics for at least one adapter' {
        $stats = Get-NetAdapterStatistics
        $stats | Should -Not -BeNullOrEmpty
    }

    It 'returns objects with expected properties' {
        $stat = Get-NetAdapterStatistics | Select-Object -First 1
        $stat.Name                  | Should -Not -BeNullOrEmpty
        $stat.ReceivedBytes         | Should -BeGreaterOrEqual 0
        $stat.SentBytes             | Should -BeGreaterOrEqual 0
        $stat.ReceivedUnicastPackets | Should -BeGreaterOrEqual 0
        $stat.SentUnicastPackets    | Should -BeGreaterOrEqual 0
    }

    It 'filters by name' {
        $stat = Get-NetAdapterStatistics -Name 'lo'
        $stat.Name | Should -Be 'lo'
    }
}

Describe 'Disable-NetAdapter WhatIf' -Skip:(-not $script:OnLinux) {
    It 'supports WhatIf without making changes' {
        { Disable-NetAdapter -Name 'lo' -WhatIf } | Should -Not -Throw
    }
}

Describe 'Enable-NetAdapter WhatIf' -Skip:(-not $script:OnLinux) {
    It 'supports WhatIf without making changes' {
        { Enable-NetAdapter -Name 'lo' -WhatIf } | Should -Not -Throw
    }
}

Describe 'Stub functions' -Skip:(-not $script:OnLinux) {
    It '<_> emits a warning' -ForEach $script:StubFunctions {
        $w = $null
        & $_ -WarningVariable w -WarningAction SilentlyContinue
        $w | Should -Not -BeNullOrEmpty
    }
}

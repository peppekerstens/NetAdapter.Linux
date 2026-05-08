#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.2.0' }

BeforeDiscovery {
    $script:OnLinux = $IsLinux

    BeforeDiscovery {
        $script:ExampleFiles = @(
            'Get-AdapterSummary.ps1',
            'Get-AdapterTraffic.ps1',
            'Invoke-AdapterBounce.ps1',
            'Get-AdapterHealthReport.ps1'
        )
    }
}

BeforeAll {
    if ($IsLinux) {
        $modulePath = Join-Path $PSScriptRoot '../NetAdapter.Linux/NetAdapter.Linux.psd1'
        Import-Module $modulePath -Force
    }
    $script:ExamplesDir = $PSScriptRoot
}

Describe 'Example file exists: <_>' -ForEach $script:ExampleFiles -Skip:(-not $script:OnLinux) {
    It 'file is present' {
        Test-Path (Join-Path $script:ExamplesDir $_) | Should -BeTrue
    }
}

Describe 'Get-AdapterSummary' -Skip:(-not $script:OnLinux) {
    It 'runs without error' {
        { & (Join-Path $script:ExamplesDir 'Get-AdapterSummary.ps1') } | Should -Not -Throw
    }
}

Describe 'Get-AdapterTraffic' -Skip:(-not $script:OnLinux) {
    It 'runs without error' {
        { & (Join-Path $script:ExamplesDir 'Get-AdapterTraffic.ps1') } | Should -Not -Throw
    }
}

Describe 'Invoke-AdapterBounce (WhatIf)' -Skip:(-not $script:OnLinux) {
    It 'runs in WhatIf mode without error' {
        # Uses WhatIf internally so no actual adapter change
        { & (Join-Path $script:ExamplesDir 'Invoke-AdapterBounce.ps1') -AdapterName 'lo' } |
            Should -Not -Throw
    }
}

Describe 'Get-AdapterHealthReport' -Skip:(-not $script:OnLinux) {
    It 'runs without error' {
        { & (Join-Path $script:ExamplesDir 'Get-AdapterHealthReport.ps1') } | Should -Not -Throw
    }
}

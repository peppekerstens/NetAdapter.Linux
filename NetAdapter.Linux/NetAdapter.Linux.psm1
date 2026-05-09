#Requires -Version 7.2
if (-not $IsLinux) {
    throw "NetAdapter.Linux cannot be loaded on Windows. On Windows, use the built-in 'NetAdapter' module: Import-Module NetAdapter`nNetAdapter.Linux is a Linux-only peer module."
}

# Dot-source all function files
Get-ChildItem -Path "$PSScriptRoot/Functions/*.ps1" |
    Where-Object { $_.Name -notlike '*.Tests.ps1' } |
    ForEach-Object { . $_.FullName }

# Load private ip wrapper as a nested module (not exported)
# Crescendo configuration: Crescendo/ip.crescendo.json
$ipModulePath = Join-Path $PSScriptRoot 'Crescendo' 'ip.psm1'
if (Test-Path $ipModulePath) {
    Import-Module $ipModulePath -Force -ErrorAction SilentlyContinue
}

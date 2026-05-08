# NetAdapter.Linux

PowerShell `NetAdapter` module for Linux — mirrors the Windows `NetAdapter` module surface using `ip link` (iproute2).

## What it does

On Windows, `Get-NetAdapter`, `Enable-NetAdapter`, `Disable-NetAdapter`, and `Get-NetAdapterStatistics` are among the most-used network administration cmdlets. On Linux, PowerShell 7.5 provides none of them.

This module wraps `ip link` and `/sys/class/net` to provide the same cmdlet names with compatible output shapes, so scripts written for Windows work on Linux with the same calls.

**Module boundary**: `NetAdapter` on Windows is a separate module from `NetTCPIP`. This module follows the same boundary — DNS and IP address cmdlets live in `NetTCPIP.Linux` and `DnsClient.Linux`.

## Requirements

- PowerShell 7.2+
- Linux only (throws on Windows — use the built-in `NetAdapter` module there)
- `iproute2` installed: `apt install iproute2`
- `Enable-NetAdapter` / `Disable-NetAdapter` require root or sudo

## Installation

```powershell
# Clone and import locally
git clone https://github.com/peppekerstens/NetAdapter.Linux
Import-Module ./NetAdapter.Linux/NetAdapter.Linux/NetAdapter.Linux.psd1
```

## Usage

```powershell
# List all adapters
Get-NetAdapter

# List physical adapters only (excludes loopback, virtual)
Get-NetAdapter -Physical

# Filter by wildcard
Get-NetAdapter -Name 'eth*'

# Traffic statistics
Get-NetAdapterStatistics

# Get stats for one adapter
Get-NetAdapterStatistics -Name eth0

# Bring an adapter up (requires root)
Enable-NetAdapter -Name eth0

# Bring an adapter down (requires root)
Disable-NetAdapter -Name eth0

# Pipeline — disable all non-loopback adapters (WhatIf first!)
Get-NetAdapter -Physical | Disable-NetAdapter -WhatIf
```

## Cmdlet Status

| Cmdlet | Status | Linux tool |
|---|:---:|---|
| `Get-NetAdapter` | ✅ Implemented | `ip -json link show` + `/sys/class/net/*/speed` |
| `Get-NetAdapterStatistics` | ✅ Implemented | `ip -s -json link show` |
| `Enable-NetAdapter` | ✅ Implemented | `ip link set <name> up` |
| `Disable-NetAdapter` | ✅ Implemented | `ip link set <name> down` |
| `Rename-NetAdapter` | 🔶 Stub | `ip link set <name> name <new>` (future) |
| `Restart-NetAdapter` | 🔶 Stub | down + up (future) |
| `Set-NetAdapter` | 🔶 Stub | limited (future) |
| `Get-NetAdapterBinding` | 🔶 Stub | Windows NDIS concept |
| All `*-NetAdapter{Checksum,Encap,IPsec,Lso,PacketDirect,PowerMgmt,Qos,Rdma,Rsc,Rss,Sriov,Uro,Uso,Vmq}*` | 🔶 Stub | Windows NDIS driver model — no Linux equivalent |
| All `Get-NetAdapterHardwareInfo`, `Get-NetAdapterSriovVf`, `Get-NetAdapterVmqQueue`, `Get-NetAdapterVPort` | 🔶 Stub | Windows NDIS driver model |
| All `*-NetAdapterAdvancedProperty` | 🔶 Stub | `ethtool` territory (future) |

**4 implemented / 74 stubs / 78 total**

## Implementation Notes

### `ip -json link show`

`iproute2` has supported `--json` output since kernel 4.12 (2017). `Get-NetAdapter` uses `ip -json link show` — no text parsing. Each link object provides `ifindex`, `ifname`, `address` (MAC), `operstate`, `flags`, `mtu`, `link_type`.

### Link speed from `/sys/class/net`

`ip link show` does not include link speed. Speed is read from `/sys/class/net/<name>/speed`. Virtual adapters (loopback, bridges, tunnels) return -1 or error from that file — these are reported as `Unknown`.

### Statistics from `ip -s -json link show`

`-s` adds `stats64` to each link object with `rx` and `tx` subtrees containing `bytes`, `packets`, `errors`, and `dropped`. `Get-NetAdapterStatistics` maps these directly.

### NDIS offload cmdlets — out of scope

The majority of the Windows `NetAdapter` surface covers hardware offload features specific to the Windows NDIS (Network Driver Interface Specification) driver model: checksum offload, LSO, RSS, VMQ, SR-IOV, packet coalescing, etc. Linux has comparable features but they are controlled via `ethtool`, `sysfs`, and driver-specific interfaces — not via a unified module-level API. These cmdlets are stubbed with `Write-Warning`.

### Unsupported parameters

- `-ComputerName` — remote management is out of scope; emits a warning if used
- Physical adapter detection is heuristic (excludes loopback, veth, docker, tun/tap, dummy, virbr)

## How we built this

**Why this module**: Evgenij Smirnov's gap analysis identified `Get-NetAdapter`, `Enable-NetAdapter`, `Disable-NetAdapter`, and `Get-NetAdapterStatistics` as the four uncovered networking cmdlets with a clear Linux implementation path. All four map directly to `iproute2` commands.

**Tool choice**: `ip -json` is the obvious choice. `ip link` has had JSON output since iproute2 4.12 (2017) and is available on every modern Linux distribution. No text parsing required.

**Module boundary decision**: An earlier version of this project merged DnsClient cmdlets into NetTCPIP.Linux. That was corrected — Windows keeps `NetAdapter`, `NetTCPIP`, and `DnsClient` as separate modules, and so do we.

**Stub strategy**: 74 of 78 cmdlets are stubs. Most of the Windows NetAdapter surface covers Windows NDIS hardware offload — features with no portable Linux equivalent. Stubbing them ensures `Get-Command -Module NetAdapter.Linux` is consistent with Windows, and scripts that call a stub get a `Write-Warning` rather than a command-not-found error.

**Companion modules**:
- [`NetTCPIP.Linux`](https://github.com/peppekerstens/NetTCPIP.Linux) — IP addresses, routing, TCP connections
- [`DnsClient.Linux`](https://github.com/peppekerstens/DnsClient.Linux) — DNS resolution and client configuration

## Version History

| Version | Changes |
|---|---|
| 0.1.0 | Initial release. Get-NetAdapter, Get-NetAdapterStatistics, Enable-NetAdapter, Disable-NetAdapter implemented. 74 stubs. |

## License

MIT

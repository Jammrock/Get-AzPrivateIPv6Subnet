# Get-AzPrivateIPv6Subnet
Generates an Azure friendly private IPv6 subnet using the private fd00::/8 block (RFC 4193) address space.

Requires PowerShell. Tested on Windows and Linux, should work on MacOS.

# Usage

## Remote execution

### Get all IPv6 address details

```PowerShell
$ipv6Subnet = (iwr https://raw.githubusercontent.com/Jammrock/Get-AzPrivateIPv6Subnet/main/Get-AzPrivateIPv6Subnet.ps1 | iex)
```

### Generate only the subnet address.

```PowerShell
$ipv6Subnet = (iwr https://raw.githubusercontent.com/Jammrock/Get-AzPrivateIPv6Subnet/main/Get-AzPrivateIPv6Subnet.ps1 | iex) | % {$_.Split("`n")} | ? { $_ -match 'CID:' } | % {($_ -replace '\s+',',').split(',')[1] }
```

## Local execution

Download Get-AzPrivateIPv6Subnet.ps1 and run the script. By default the full address details are output. 

```PowerShell
.\Get-AzPrivateIPv6Subnet.ps1
```

Use -Subnet to output only the subnet address in CIDR format.

```PowerShell
.\Get-AzPrivateIPv6Subnet.ps1 -Subnet
```

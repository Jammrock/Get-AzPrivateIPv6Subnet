# Get-AzPrivateIPv6Subnet

[CmdletBinding()]
param (
    [Parameter()]
    [switch]
    $Subnet
)

function Get-RandomHexidecimalDigit
{
    # IPv6 address are hexidecimal numbers, so 0-F
    [string[]]$IPv6Chars = '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'

    # get a random number between 0 and 15, a random number of times
    $seedNum = Get-Random -Minimum 1 -Maximum 100

    # build an array of random numbers
    $randArr = [System.Collections.Generic.List[string]]::new()
    0..$seedNum | & { process { $null = $randArr.Add($IPv6Chars[(Get-Random -Maximum 15)]) } }

    return ($randArr[(Get-Random -Minimum 0 -Maximum $seedNum)])
}


# IPv6 private addresses start with fd
$prefix = "fd"

# Azure IPv6 subnets must be /64
$suffix = "::/64"



# get 10 random hex digits for the Global ID
$GlobalID = ""

for ($i = 0; $i -lt 10; $i++)
{
    # get a hexidecimal digit
    $GlobalID += (Get-RandomHexidecimalDigit)
}


# get 4 random hex digits for the subnet ID
$SubnetID = ""

for ($i = 0; $i -lt 4; $i++)
{
    # get a hexidecimal digit
    $SubnetID += (Get-RandomHexidecimalDigit)
}

$rawIPv6Address = "$prefix$GlobalID$SubnetID"

$formattedIPv6Address = "$($rawIPv6Address -replace '....(?!$)', '$&:')$suffix"

if ($Subnet.IsPresent)
{
    return $formattedIPv6Address
}
else 
{
 return (@"
Prefix/L:         fd
Global ID:        $GlobalID
Subnet ID:        $SubnetID
Combined/CID:     $formattedIPv6Address
IPv6 addresses:   $($rawIPv6Address -replace '....(?!$)', '$&:'):xxxx:xxxx:xxxx:xxxx
"@)
}
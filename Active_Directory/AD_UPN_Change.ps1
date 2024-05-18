# Import ActiveDirectory Module
Import-Module ActiveDirectory

# Replace with the old suffix
$OldSuffix = "contoso.org"

# Replace with the new suffix
$NewSuffix = "contoso.ca"

# Replace with the OU you want to change suffixes for
$OU = "DC=contoso,DC=org"

# Replace with the name of your AD server
$Server = "Contoso-AD-Server-Hostname"

Get-ADUser -SearchBase $OU -filter * | ForEach-Object {
$NewUPN = $_.UserPrincipalName.Replace($OldSuffix,$NewSuffix)
$_ | Set-ADUser -server $Server -UserPrincipalName $NewUPN
}
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


Function UPNReplace {
    Get-ADUser -SearchBase $OU -filter * | ForEach-Object {
    $NewUPN = $_.UserPrincipalName.Replace($OldSuffix,$NewSuffix)
    $_ | Set-ADUser -server $Server -UserPrincipalName $NewUPN
    }
}


Function NameReplace {
Get-ADUser -SearchBase $OU -filter * | ForEach-Object {
    $FirstName = $_.givenName.replace(" ","")  
    $LastName = $_.surname.replace(" ","")  
    $NewUPN = "$FirstName.$LastName@$NewSuffix" 
    $_ | Set-ADUser -server $Server -UserPrincipalName $NewUPN
    }
}




Function Menu
{
    param (
        [string]$Title = 'UPN Replacement Optons'
    )
    Write-Host "================ $Title ================
"
    Write-Host "Select the option in how you wish to target the user's to mass edit their UPNs"
    Write-Host "Press 'A' to target old UPN suffix" -ForegroundColor White -BackgroundColor Black
    Write-Host "Press 'B' to target First/Last names with new suffix" -ForegroundColor White -BackgroundColor Black
    Write-Host ""


do
 {
     $Selection = Read-Host "
Please make a selection"
     switch ( $Selection ) 
    {
    "1" 
    {
      Write-host "You entered option [A]" -ForegroundColor Green
        UPNReplace
      Start-Sleep -Seconds 1
    }
    "0" 
    {
      Write-host "You entered option [B]" -ForegroundColor Red
        NameReplace
      Start-Sleep -Seconds 1
    }
  }
}
until ( $Selection -notmatch "X" )


Write-Host "Script Completed!" -ForegroundColor Green -BackgroundColor Black
Start-Sleep -Seconds 5
Exit
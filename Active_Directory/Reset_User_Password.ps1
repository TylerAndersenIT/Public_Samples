[cmdletbinding()]            
param(
 [Parameter(Position=0,Mandatory=$true)]            
 [string]$User,   
 [Parameter(Position=1,Mandatory=$true)]            
 [string]$Password                  
)

$NewPassword = ConvertTo-SecureString -String $Password -AsPlainText –Force

Try{
 Set-ADAccountPassword $_.User -NewPassword $NewPassword -Reset -Passthru | Set-ADuser -ChangePasswordAtLogon $False

 Write-Host "
 Successfully Reset Password For [$User]" -ForegroundColor Green -BackgroundColor Black
}
Catch{
 Write-Host ""
 Write-Warning "Failed To Reset Password For [$User]"
}
<#

The purpose of this script is to enable auditing of a Microsoft Exchange specific mailbox user account

#>

Write-Warning "This script should be run by a mailbox administrator as end user accounts will fail."

Write-Host "
Please enter the target user mailbox username below. For example JSmith:" -ForegroundColor Yellow -BackgroundColor Black
$Target = Read-Host

#Check audit logging status
Write-Host "
Checking audit logging status for account [$Target]..." -ForegroundColor Yellow -BackgroundColor Black
Get-Mailbox $Target | fl *audit* 

#Turn on audit logging for user
Write-Host "
Enabling audit logging for account [$Target]..." -ForegroundColor Yellow -BackgroundColor Black
Set-Mailbox -Identity $Target -AuditEnabled $true

Write-Host "Done!" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Ending Script in 5 seconds." -ForegroundColor Cyan -BackgroundColor Black
Start-Sleep -Seconds 5
Exit
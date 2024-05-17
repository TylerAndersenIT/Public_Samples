$TargetPrintServer = "HOSTNAME_HERE"
cls

Write-Host "
--------------------------------------------------------------------------------------" -ForegroundColor Black
Write-Warning "This script should be run as a domain admin, or if required enterprise admin."
Write-Host "--------------------------------------------------------------------------------------


" -ForegroundColor Black

<# Uncomment this if you want to be prompted for server name
Write-Host "Enter Target Printer Server Hostname" -Foreground Yellow -Background Black
$TargetPrintServer = Read-Host
Write-Host "You Entered: [$TargetPrintServer]
" -Foreground Green -Background Black
Start-Sleep -Seconds 1
#>


Function RestartSpooler {
$Date = Get-Date -Format "yyyy-MM-dd HH:mm" # | foreach {$_ -replace ":", "."}

Write-Host "Attempting to connect to [$TargetPrintServer]. Please Wait...
" -ForegroundColor Yellow -BackgroundColor Black
If ((Test-NetConnection $TargetPrintServer -WarningAction SilentlyContinue).PingSucceeded -eq $false)              
    {
    Write-Host "[$Date] Connection Test To [$TargetPrintServer]: [Failed]" -ForegroundColor Red -BackgroundColor Black
    Write-Host "SUGGESTION: Troubleshoot the connection first and then retry." -ForegroundColor Yellow -BackgroundColor Black
    Start-Sleep -Seconds 2
    Write-Host "
    Would you like to retry now?    
" -ForegroundColor Magenta -BackgroundColor Black
    Start-Sleep -Seconds 1
    ShowMenu
    }


ElseIf ((Test-NetConnection $TargetPrintServer -WarningAction SilentlyContinue).PingSucceeded -eq $true)                      
    {
    Write-Host "[$Date] Connection Test To [$TargetPrintServer]: [Successful]" -ForegroundColor Green -BackgroundColor Black
    Write-Host "Attempting to restart print spooler on server [$TargetPrintServer]" -ForegroundColor Yellow -BackgroundColor Black
    Restart-Service -InputObject $(Get-Service -Name SPOOLER -Computer $TargetPrintServer)
    Write-Host "
    Please verify the results now... This script will end in 5 seconds." -ForegroundColor Cyan -BackgroundColor Black
    Start-Sleep -Seconds 5
    Exit
    }

}



Function ShowMenu
{
    param (
        [string]$Title = 'RETRY SCRIPT PROMPT'
    )
    Write-Host "================ $Title ================
"
    Write-Host "Press 'y' for YES" -ForegroundColor Green -BackgroundColor Black
    Write-Host "Press 'n' for NO 
" -ForegroundColor Red -BackgroundColor Black


do
 {
     $Selection = Read-Host "
Please make a selection"
     switch ( $Selection ) 
    {
    "y" 
    {
      Write-host "You entered [YES]" -ForegroundColor Green
      Start-Sleep -Seconds 1
    }
    "n" 
    {
      Write-host "You entered [NO]" -ForegroundColor Red
      Start-Sleep -Seconds 1
    }
  }
}
until ( $Selection -notmatch "X" )



    If ($Selection -eq "y") {
RestartSpooler
}

    If ($Selection -eq "n") {
Write-Host "
This script will end in 5 seconds." -ForegroundColor Cyan -BackgroundColor Black
Start-Sleep -Seconds 5
Exit
}


}


### ACTIONS ###

RestartSpooler
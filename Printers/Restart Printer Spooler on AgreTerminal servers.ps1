$TargetPrintServer = "HOSTNAME_HERE"
# $TargetPrintServer = Read-Host # Uncomment this if you want to be prompted for server name

Function RestartSpooler {

If ((Test-NetConnection $TargetPrintServer -WarningAction SilentlyContinue).PingSucceeded -eq $false)              
    {
    $Date = Get-Date -Format "yyyy-MM-dd_HH.mm" | foreach {$_ -replace ":", "."}
    Write-Host "Connection Test: [Failed]" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Troubleshoot the connection and retry later." -ForegroundColor Yellow -BackgroundColor Black
    }


ElseIf ((Test-NetConnection $TargetPrintServer -WarningAction SilentlyContinue).PingSucceeded -eq $true)                      
    {
    $Date = Get-Date -Format "yyyy-MM-dd_HH.mm" | foreach {$_ -replace ":", "."}
    Write-Host "Connection Test: [Successful]" -ForegroundColor Green -BackgroundColor Black
    Write-Host "Attempting to restart print spooler on server [$TargetPrintServer]" -ForegroundColor Yellow -BackgroundColor Black
    Restart-Service -InputObject $(Get-Service -Name SPOOLER -Computer $TargetPrintServer)
    Write-Host "
    Please verify the results now... This script will end in 5 seconds." -ForegroundColor Cyan -BackgroundColor Black
    Start-Sleep -Seconds 5
    }

}
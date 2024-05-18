<#

The purpose of this script is if you have both HyperV and VMware for whatever reason installed on a Windows 10/11 OS
You also have Credential Guard obviously available on your OS which can block VMware from working.
This script prompts the user to toggle between on and off for Hyper-V launchtype.

ON = HyperV can work, VMware cannot work
OFF = HyperV cannot work, VMware can work

#>

Function ToggleHyperV
{
    param (
        [string]$Title = 'TOGGLE HYPER-V LAUNCHTYPE'
    )
    Write-Host "================ $Title ================
"
    Write-Host "Press '1' for ON/AUTO" -ForegroundColor Green -BackgroundColor Black
    Write-Host "Press '0' for OFF 
" -ForegroundColor Red -BackgroundColor Black


do
 {
     $Selection = Read-Host "
Please make a selection"
     switch ( $Selection ) 
    {
    "1" 
    {
      Write-host "You entered [ON/AUTO]" -ForegroundColor Green
        $Toggle = "auto"
      Start-Sleep -Seconds 1
    }
    "0" 
    {
      Write-host "You entered [OFF]" -ForegroundColor Red
        $Toggle = "off"
      Start-Sleep -Seconds 1
    }
  }
}
until ( $Selection -notmatch "X" )


Write-Host "Setting Hypervisor Launchtype to [$Toggle]" -ForegroundColor Yellow -BackgroundColor Black
bcdedit /set hypervisorlaunchtype $Toggle
Write-Host "Attempt to toggle launchtype done!" -ForegroundColor Cyan -BackgroundColor Black


Write-Host "In order to complete this process your computer needs to reboot.
Would you like to immediately reboot?
" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "Press [y] for 'YES'" -ForegroundColor Green -BackgroundColor Black
Write-Host "Press [n] for 'NO'" -ForegroundColor Red -BackgroundColor Black

    If ($Selection -eq "y") {
    Write-Host "Rebooting Now..." -ForegroundColor Yellow -BackgroundColor Black
    Start-Sleep -Seconds 2
    Shutdown.exe /r -t 0
    }

    If ($Selection -eq "n") {
    Write-Host "Skipping the reboot." -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "This script will end in 5 seconds." -ForegroundColor Cyan -BackgroundColor Black
    Start-Sleep -Seconds 5
    Exit
    }

}

ToggleHyperV
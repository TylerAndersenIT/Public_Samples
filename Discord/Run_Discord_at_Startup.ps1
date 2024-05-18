<#

This script was originally made after one of the previous Discord updates broke the Windows StartupFolder shortcut.
The purpose of this script is to always keep the most up to date version of discord running during Windows startup.



Create a Scheduled Task to run this powershell with the following attributes and name it whatever you want;
    
    General:
            When running the task, use the following user account: [Administrators]
            [x] Run with highest privledges

    Trigger: 
            At log on

    Actions: 
            Program/script:  powershell.exe
            Add arguments:   -ExecutionPolicy Unrestricted -WindowStyle Hidden -File Run_Discord.ps1
            Start in:        C:\Folders_This_Script_Is_In\
#>



<#  ERROR CODE INDEX

001 = Directory not found
        --> Verify app is installed <--

#>
$ErrorCode = "ERROR CODE"


# -------------------------------------------------

# Log Function
$LogFolder = "C:\Logs"
$LogFile = "$LogFolder\Run_Discord.log"
Function Log
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$LogMessage = "$Stamp -- $LogString"
Add-content $LogFile -value $LogMessage
}

# -------------------------------------------------

Function RunDiscordCanary {

# Install Directory for Discord
$DiscordCanaryDir = "$env:USERPROFILE\AppData\Local\DiscordCanary\"
# ONLY this variable should ever need editing and only if you install Discord into a nonstandard folder somehow

Write-Host "
    Checking to see if [$DiscordCanaryDir] exists...    " -ForegroundColor Yellow -BackgroundColor Black


If (Test-Path -Path $DiscordCanaryDir) {
    Write-Host "
    [$DiscordCanaryDir] exists!    " -ForegroundColor Green -BackgroundColor Black

    Write-Host "
    Currently looking inside [$DiscordCanaryDir] to find where the current version of Discord Canary is installed..." -ForegroundColor Yellow -BackgroundColor Black
    # Find where current version of discord app is
    $CurrentDiscordCanaryApp = Get-ChildItem -Path $DiscordCanaryDir -Filter DiscordCanary.exe -Recurse -ErrorAction SilentlyContinue | % { $_.FullName }
    Log "$CurrentDiscordCanaryApp"

    # Tell me where current version is
    Write-Host "
    Results: [$CurrentDiscordCanaryApp]" -ForegroundColor Green -BackgroundColor Black

    # Create Shortcut file in Startup folder
    $StartupDir = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

        # Deletes old shortcut file
        Write-Host "
    Deleting old shortcut file [$StartupDir\Discord_Canary.lnk]... " -ForegroundColor Red -BackgroundColor Black -NoNewline
        Remove-Item "$StartupDir\Discord_Canary.lnk"
        Write-Host "Done!" -ForegroundColor Green -BackgroundColor Black
    
        # Makes new shortcut file
        Write-Host "
    Creating new shortcut file [$StartupDir\Discord_Canary.lnk]... " -ForegroundColor Yellow -BackgroundColor Black -NoNewline
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$StartupDir\Discord_Canary.lnk")
        $Shortcut.TargetPath = "$CurrentDiscordCanaryApp"
        $Shortcut.Save()

        If (Test-Path -Path $StartupDir\Discord_Canary.lnk) {
            Write-Host "Done!" -ForegroundColor Green -BackgroundColor Black
            } else {
            Log "(!)
            $ErrorCode 002: Discord shortcut [Discord_Canary.lnk] not found in directory [$StartupDir]
            "
                #Error code if the shortcut file is not found
                Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
                Write-Warning "$ErrorCode 002"
                Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
                Write-Host "[$StartupDir\Discord_Canary.lnk] NOT FOUND!" -ForegroundColor Red -BackgroundColor Black
                Write-Host "Check to see if Discord_Canary.lnk is available" -ForegroundColor Red -BackgroundColor Black
                Start-Sleep -Seconds 10
            }

    # Makes a symbolic link
    #New-Item -ItemType SymbolicLink  -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "Discord_Canary.lnk" -Value "$CurrentDiscordCanaryApp"

    <#
    # Run the app from roaming folder
    Write-Host "
    Launching Discord...    " -ForegroundColor Yellow -BackgroundColor Black
    Start-Process -FilePath $CurrentDiscordCanaryApp
    #>

    <#
    # Run the app from startup folder
    Write-Host "
    Launching Discord...    " -ForegroundColor Yellow -BackgroundColor Black
    Start-Process -FilePath $StartupDir\Discord_Canary.lnk
    #>

} else {

    Log "(!)
$ErrorCode 001: Discord app not found in directory [$DiscordCanaryDir]
"

    #Error code if the install directory is not found
    Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
    Write-Warning "$ErrorCode 001"
    Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
    Write-Host "[$DiscordCanaryDir] NOT FOUND!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Check to see if Discord has been installed in the correct directory" -ForegroundColor Red -BackgroundColor Black
    Start-Sleep -Seconds 10
}

}


# ---------------------------#


Function RunDiscord {

# Install Directory for Discord
$DiscordDir = "$env:USERPROFILE\AppData\Local\Discord\"
# ONLY this variable should ever need editing and only if you install Discord into a nonstandard folder somehow

Write-Host "
    Checking to see if [$DiscordDir] exists...    " -ForegroundColor Yellow -BackgroundColor Black


If (Test-Path -Path $DiscordDir) {
    Write-Host "
    [$DiscordDir] exists!    " -ForegroundColor Green -BackgroundColor Black

    Write-Host "
    Currently looking inside [$DiscordDir] to find where the current version of Discord is installed..." -ForegroundColor Yellow -BackgroundColor Black
    # Find where current version of discord app is
    $CurrentDiscordApp = Get-ChildItem -Path $DiscordDir -Filter Discord.exe -Recurse -ErrorAction SilentlyContinue | % { $_.FullName }
    Log "$CurrentDiscordApp"

    # Tell me where current version is
    Write-Host "
    Results: [$CurrentDiscordApp]" -ForegroundColor Green -BackgroundColor Black

    # Create Shortcut file in Startup folder
    $StartupDir = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

        # Deletes old shortcut file
        Write-Host "
    Deleting old shortcut file [$StartupDir\Discord.lnk]... " -ForegroundColor Red -BackgroundColor Black -NoNewline
        Remove-Item "$StartupDir\Discord.lnk"
        Write-Host "Done!" -ForegroundColor Green -BackgroundColor Black
    
        # Makes new shortcut file
        Write-Host "
    Creating new shortcut file [$StartupDir\Discord.lnk]... " -ForegroundColor Yellow -BackgroundColor Black -NoNewline
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut("$StartupDir\Discord.lnk")
        $Shortcut.TargetPath = "$CurrentDiscordApp"
        $Shortcut.Save()

        If (Test-Path -Path $StartupDir\Discord.lnk) {
            Write-Host "Done!" -ForegroundColor Green -BackgroundColor Black
            } else {
            Log "(!)
            $ErrorCode 002: Discord shortcut [Discord.lnk] not found in directory [$StartupDir]
            "
                #Error code if the shortcut file is not found
                Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
                Write-Warning "$ErrorCode 002"
                Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
                Write-Host "[$StartupDir\Discord.lnk] NOT FOUND!" -ForegroundColor Red -BackgroundColor Black
                Write-Host "Check to see if Discord.lnk is available" -ForegroundColor Red -BackgroundColor Black
                Start-Sleep -Seconds 10
            }

    # Makes a symbolic link
    #New-Item -ItemType SymbolicLink  -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Name "Discord.lnk" -Value "$CurrentDiscordApp"

    <#
    # Run the app from roaming folder
    Write-Host "
    Launching Discord...    " -ForegroundColor Yellow -BackgroundColor Black
    Start-Process -FilePath $CurrentDiscordApp
    #>

    <#
    # Run the app from startup folder
    Write-Host "
    Launching Discord...    " -ForegroundColor Yellow -BackgroundColor Black
    Start-Process -FilePath $StartupDir\Discord.lnk
    #>

} else {

    Log "(!)
$ErrorCode 001: Discord app not found in directory [$DiscordDir]
"

    #Error code if the install directory is not found
    Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
    Write-Warning "$ErrorCode 001"
    Write-Host "-----------------------" -ForegroundColor Red -BackgroundColor Black
    Write-Host "[$DiscordDir] NOT FOUND!" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Check to see if Discord has been installed in the correct directory" -ForegroundColor Red -BackgroundColor Black
    Start-Sleep -Seconds 10
}


}


# Comment out whichever of below to disable them

RunDiscord # Stable public release of discord
# Download: https://discord.com/download

RunDiscordCanary # Unstable newest features release of discord
# Download: https://discordapp.com/api/download/canary?platform=win
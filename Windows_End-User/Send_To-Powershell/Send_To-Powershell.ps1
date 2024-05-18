<#'==========================================================================
'
' NAME: SendToPowerShell.ps1
' AUTHOR: Tyler Andersen
' DATE: 3/4/2016
'          
'==========================================================================
#>

$SendTo = [System.Environment]::GetFolderPath("SendTo")
$OS = gwmi win32_OperatingSystem
$OSDir = $OS.WindowsDirectory.Trim()
$objShell = New-Object -com "Wscript.Shell"
if ($OS.OSArchitecture -eq "64-bit")
{
$objShortcut = $objShell.CreateShortcut($SendTo + "\PowerShell(x86).lnk")
$objShortcut.TargetPath = "$OSDir\SysWOW64\WindowsPowerShell\v1.0\PowerShell.Exe"
$objShortcut.Save()
}
$objShortcut = $objShell.CreateShortcut($SendTo + "\PowerShell.lnk")
$objShortcut.TargetPath = "$OSDir\System32\WindowsPowerShell\v1.0\PowerShell.Exe"
$objShortcut.Save()
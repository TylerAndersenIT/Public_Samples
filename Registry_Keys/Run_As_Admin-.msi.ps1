cls
Write-Warning "This script must be run as admin!
"
Write-Host "
PURPOSE: The purpose of this script is to add a context menu option to .msi files to 'Run As Administrator'
" -ForegroundColor Red -BackgroundColor Black

cd "Registry::HKEY_CLASSES_ROOT\Msi.Package\shell"


Function NewPath {
Write-Host "Creating New Path [$Path]" -ForegroundColor Yellow -BackgroundColor Black
New-Item -Path "$Path"
Write-Host "Attempt finished." -ForegroundColor Green -BackgroundColor Black
}


Function EditString {
Write-Host "Modifying String [$Name] with value [$Value]" -ForegroundColor Yellow -BackgroundColor Black
New-ItemProperty -Name $Name -Path $Path -Value $Value -PropertyType String -Force
Write-Host "Attempt finished." -ForegroundColor Green -BackgroundColor Black

$Results = Get-ItemPropertyValue -Name $Name -Path $Path
Write-Host "Verify the results:" -ForegroundColor Yellow -BackgroundColor Black
Write-Host $Results -ForegroundColor Black -BackgroundColor White
}


$Path = "runas" # Computer\HKEY_CLASSES_ROOT\Msi.Package\shell\runas
$Name = "(Default)"
$Value = 'Run As Administrator'
NewPath
EditString


$Path = "runas\Command" # Computer\HKEY_CLASSES_ROOT\Msi.Package\shell\runas\Command
$Name = "(Default)"
$Value = 'msiexec /i “%1”'
NewPath
EditString
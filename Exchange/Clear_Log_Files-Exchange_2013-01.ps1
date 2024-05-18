#|--------------------------------------------------------------------------------------------|
#| Script:   Clear Log Files -- Exchange2013-01.ps1                                           |
#| Author:   Tyler Andersen                                                                   |
#| Date:     December 5, 2017                                                                 |
#| Modified: December 5, 2017                                                                 |
#| Comments: Script used to automatically purge all log files older than 60 days              |
#|           Scheduled task should run weekly on [DAY_HERE] at [TIME_HERE]                    |
#|--------------------------------------------------------------------------------------------|

$Limit = (Get-Date).AddDays(-60)
$LogDir = "\\exchange2013-01\C$\inetpub\logs\LogFiles\W3SVC2"

# Delete files older than the $Limit.
Get-ChildItem -Path $LogDir -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $Limit } | Remove-Item -Force
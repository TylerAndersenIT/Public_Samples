<#
|--------------------------------------------------------------------------------------------|
| Script: Cyfin HTML Mover                                                                   |
| Author: Tyler Andersen                                                                     |
| Date: December 8, 2015                                                                     |
| Last Modified: April 1, 2016                                                               |
| Comments: Script used to automatically move html report files to their correct directory   |
|                                                                                            |
|--------------------------------------------------------------------------------------------|
#>

<#

The purpose for this script was because my manager's Manager would spend hours every Tuesday
morning manually creating and moving each employees web history file into the appropriate 
department folder for 500+ employees. He demanded I take on more 'manager tier' roles in an
attempt to groom me into his position. I told him this is a waste of both of our time and I
will automate this task so we can both focus on real work. Coming from a develop history my
manager's manager balked at the idea that moving files can be automated. 15 Mins of typing
later and I have reduced labour costs by over 156 hours annually.

This simple script alone earned me a 29% increase in pay the following employee review period,
Plus a 10% of salary bonus cheque 2 weeks after hitting production.

If your boss or others are wasting time doing petty tasks like moving web history reports
manually, consider automating these tasks for them. And who says WFH is bad for productivity.

#>


#---------------------------------------------------------------------------------------------

$CyfinServerHostname = "Enter_Cyfin_Hostname_Here" # Edit this with your Cyfin server hostname

#---------------------------------------------------------------------------------------------

$todaydate = "{0:yyyyMMdd}" -f (get-date)
#Looks up current date

$today = "{0:yyyy-MM-dd}" -f (get-date)
#Looks up current date

$year = Get-Date
$year = $year.ToString("yyyy")
#Looks up the current year
#Used in the directory variables to find the current year folder

#---------------------------------------------------------------------------------------------

Function MoveReport {
Move-Item $DeptDir\*.html $DeptDir\$year\$today
# Moves all HTML files from parent directories to correctly dated child directories
# Must be run after all reports have been completed.
}

#---------------------------------------------------------------------------------------------

$Log = "\\$CyfinServerHostname\Dept\Web Reports\Powershell_Scripts\Log\"
#Log Folder

Set-Location $Log\$year
New-Item -ItemType directory -Path "$Log\$year\$today"

Function MoveLog {
Move-Item $DeptDir\*.txt $DeptDir\$year\$today
# Moves all Text files from parent directories to correctly dated child directories
# Must be run after all reports have been completed.
}

Function LogDept {
Set-Location $DeptDir\$year\$today
Get-Childitem -Name -Path $DeptDir\$year\$today
Dir > $Log\$Dept-Log.txt
Dir > $Log\$year\$today\$Dept-Log.txt
# Logging of folder contents in response to my manager's manager suggesting automation will delete not move files
}

#---------------------------------------------------------------------------------------------

Function MoveAndLog {
$DeptDir = "\\$CyfinServerHostname\Dept\Web Reports\$Dept" # Sets department root folder
MoveReport # Moves reports
MoveLog # Moves log files
LogDept # Logs file contents
}

#---------------------------------------------------------------------------------------------

$Dept = "Accounting"
MoveAndLog

$Dept = "Administration"
MoveAndLog

# Repeat this process for each department
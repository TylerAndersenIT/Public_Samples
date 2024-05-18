#|--------------------------------------------------------------------------------------------|
#| Script: Cyfin Annual Year Directory Maker                                                  |
#| Author: Tyler Andersen                                                                     |
#| Date: December 12, 2016                                                                    |
#| Modified: December 12, 2016                                                                |
#| Comments: Script used to automatically create a directory for next year in each dept folder|
#|           Scheduled task should run annually January 1st at 12:00 AM                       |
#|--------------------------------------------------------------------------------------------|

$year = Get-Date
$year = $year.ToString("yyyy")
#Looks up the current year
#Used in the directory variables to find the current year folder

#---------------------------------------------------------------------------------------------

Function NewYearDeptDir {
$CyfinServerHostname = "Enter_Cyfin_Hostname_Here" # Edit this with your Cyfin server hostname
$DeptDir = "\\$CyfinServerHostname\Dept\Web Reports\$Dept" # Edit this with the general root directory where reports go
New-Item -ItemType directory -Path "$DeptDir\$year" # Creates a new folder with the file name YYYY
}

#---------------------------------------------------------------------------------------------

$Dept = "Accounting"
NewYearDeptDir

$Dept = "Administration"
NewYearDeptDir

# Repeat this process for each department
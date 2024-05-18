#|--------------------------------------------------------------------------------------------|
#| Script: Cyfin Auto Directory                                                               |
#| Author: Tyler Andersen                                                                     |
#| Date: December 7, 2015                                                                     |
#| Modified: April 1, 2016                                                                    |
#| Comments: Script used to automatically create a directory for each report                  |
#|       Scheduled task should run weekly at 10:30 PM - Files are dropped from Cyfin at 11 PM |
#|--------------------------------------------------------------------------------------------|

$date = Get-Date
$date = $date.ToString("yyyy-MM-dd")
#Looks up the current date and forms it into YYYY-MM-DD
#Used to create a folder with the date as its name

#---------------------------------------------------------------------------------------------

$year = Get-Date
$year = $year.ToString("yyyy")
#Looks up the current year
#Used in the directory variables to find the current year folder

#---------------------------------------------------------------------------------------------

Function DeptNewPath {
New-Item -ItemType directory -Path "$Dept\$year\$date" 
# Creates a new folder inside the current year parent directory with the file name YYYY-MM-DD
}

#---------------------------------------------------------------------------------------------

$Dept = "Accounting"
DeptNewPath

$Dept = "Administration"
DeptNewPath

# Repeat this process for each department
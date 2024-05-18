' This script loops through all printers on a host and deletes any printer found with a device ID (name) as specified.
'
' The results of printer deletion are logged to a CSV file that lists the host name, printer removed, and time of removal.
'
' Please specify both the name of the printer(s) and the full UNC path of the results file.
'

Option Explicit
Dim objFSO, WshShell, objWMIService, colInstalledPrinters, objPrinter, strOutput, objResults, strResultsFile, arrDeletePrinters, strPrinter
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2") 
Set colInstalledPrinters = objWMIService.ExecQuery("Select * from Win32_Printer") 

' Specify the full UNC path of the CSV results file.
' EX: ]]strResultsFile = "\\dc\shared\test.csv"
strResultsFile = "\\dc\shared\Printers.csv"

' Open the results file
' Make sure file is closed before opening / writing
On Error Resume Next
Do
	Err.Clear
	Set objResults = objFSO.OpenTextFile(strResultsFile, 8, True)
	If Err.number = 0 Then Exit Do
	WScript.Sleep 1000
Loop
On Error Goto 0

' Add the printer(s) to delete to the array.  Let's say we have a printer named "foo" and a printer named "bar"
' One printer: arrDeletePrinters = Array("foo")
' Two printers: arrDeletePrinters = Array("foo","bar")
' Three printers.... etc.
arrDeletePrinters = Array("")

' Loop through all printers
For Each objPrinter in colInstalledPrinters
	
	' Search for matching printer(s), delete, and record
	For Each strPrinter in arrDeletePrinters
		If Not InStr(1, objPrinter.DeviceID, strPrinter, 1) = 0 Then
			objPrinter.Delete_ 
			objResults.Write WshShell.ExpandEnvironmentStrings("%COMPUTERNAME%")  & "," & objPrinter.DeviceID & "," & Now & VbCrLf
		End If
	Next

Next

' Close the results file
objResults.Close
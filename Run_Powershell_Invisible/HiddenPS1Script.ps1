<# Read-Me Description

4 Components:

HiddenPS1Script.bat
	Calls powershell, and tells it to run HiddenPS1Script.PS1
	Enter your code into here, whatever project you may have

HiddenPS1Script.PS1
	The actual code of the project

HiddenPS1Script.VBS
	Used to run a specified batch file (HiddenPS1Script.bat) silently	

SilentRunVBS.bat
	Runs the VBS Script and the batch file (HiddenPS1Script.bat) together

You can run the Powershell script, or you can run SilentRunVBS to force it to be silent.

#>




# Enter your script to be run silently in here
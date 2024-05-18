'=============================================='
' NAME: Send To PowerShell
' AUTHOR: Tyler Andersen
' DATE: 3/4/2016
'
' COMMENT: Adds SendTo right menu choice for PowerShell.
'
'
'================================================
Set WSHShell = CreateObject("WScript.Shell")
Set WSHNetwork = CreateObject("WScript.Network")
Set objFSO = CreateObject("Scripting.FileSystemObject")
WinDir = WshShell.ExpandEnvironmentStrings("%WinDir%")
strSendToFolder = WSHShell.SpecialFolders("SendTo")

If Not objFSO.FolderExists(Windir & "\sysWOW64") Then 
    strPathToNotepad = WinDir & "\system32\WindowsPowerShell\v1.0\powershell.exe"
    Set objShortcut = WSHShell.CreateShortcut(strSendToFolder & _
     "\PowerShell.lnk")
    objShortcut.TargetPath = strPathToNotepad
    objShortcut.Save
Else
    strPathToNotepad = WinDir & "\sysWOW64\WindowsPowerShell\v1.0\powershell.exe"
    Set ps86 = WSHShell.CreateShortcut(strSendToFolder & _
     "\PowerShell(x86).lnk")
    ps86.TargetPath = strPathToNotepad
    ps86.Save
    strPathToNotepad = WinDir & "\system32\WindowsPowerShell\v1.0\powershell.exe"
    Set ps64 = WSHShell.CreateShortcut(strSendToFolder & _
     "\PowerShell.lnk")
    ps64.TargetPath = strPathToNotepad
    ps64.Save
End If